import { common } from '@kit.AbilityKit';
import { FocusDurationMinutes } from '../constants/DurationConstants';
import { FocusEndReason, FocusSession, SessionResultRouteParams } from '../models/FocusSession';
import { SessionRepository } from '../storage/SessionRepository';
import { TimeUtils } from '../utils/TimeUtils';
import { ValidationResult, ValidationUtils } from '../utils/ValidationUtils';

/**
 * 墙钟驱动：剩余时间由「当前时间 − 开始时间 − 累计暂停」推导，
 * 不依赖 setInterval 连续运行，锁屏/前后台返回后仍能对齐。
 */
export interface FocusWallClockState {
  totalSeconds: number;
  wallStartedAtMs: number;
  totalPausedMs: number;
  pauseStartedAtMs: number | null;
}

export interface FocusDerivedSnapshot {
  remainingSeconds: number;
  elapsedSeconds: number;
  isPaused: boolean;
}

export interface SaveSessionPayload extends SessionResultRouteParams {
  note: string;
}

export class FocusViewModel {
  private sessionRepository: SessionRepository = new SessionRepository();

  createRuntimeState(durationMinutes: FocusDurationMinutes): FocusWallClockState {
    const totalSeconds: number = durationMinutes * 60;
    return {
      totalSeconds,
      wallStartedAtMs: Date.now(),
      totalPausedMs: 0,
      pauseStartedAtMs: null
    };
  }

  deriveSnapshot(state: FocusWallClockState): FocusDerivedSnapshot {
    let activeElapsedMs: number;
    if (state.pauseStartedAtMs !== null) {
      activeElapsedMs = state.pauseStartedAtMs - state.wallStartedAtMs - state.totalPausedMs;
    } else {
      activeElapsedMs = Date.now() - state.wallStartedAtMs - state.totalPausedMs;
    }
    const rawElapsedSec: number = Math.floor(activeElapsedMs / 1000);
    const elapsedSeconds: number = Math.min(Math.max(0, rawElapsedSec), state.totalSeconds);
    const remainingSeconds: number = Math.max(0, state.totalSeconds - elapsedSeconds);
    return {
      remainingSeconds,
      elapsedSeconds,
      isPaused: state.pauseStartedAtMs !== null
    };
  }

  togglePause(state: FocusWallClockState): FocusWallClockState {
    if (state.pauseStartedAtMs !== null) {
      const pauseDur: number = Date.now() - state.pauseStartedAtMs;
      return {
        totalSeconds: state.totalSeconds,
        wallStartedAtMs: state.wallStartedAtMs,
        totalPausedMs: state.totalPausedMs + pauseDur,
        pauseStartedAtMs: null
      };
    }
    return {
      totalSeconds: state.totalSeconds,
      wallStartedAtMs: state.wallStartedAtMs,
      totalPausedMs: state.totalPausedMs,
      pauseStartedAtMs: Date.now()
    };
  }

  validateNote(note: string): ValidationResult {
    return ValidationUtils.validateNote(note);
  }

  async saveSession(context: common.Context, payload: SaveSessionPayload): Promise<FocusSession> {
    const session: FocusSession = {
      id: TimeUtils.createSessionId(),
      taskName: payload.taskName,
      plannedDurationMinutes: payload.plannedDurationMinutes,
      actualFocusSeconds: payload.actualFocusSeconds,
      endReason: payload.endReason,
      note: payload.note,
      startedAt: payload.startedAt,
      endedAt: payload.endedAt,
      dateKey: TimeUtils.formatDateKey(new Date(payload.endedAt))
    };
    await this.sessionRepository.saveSession(context, session);
    return session;
  }

  isCompleted(reason: FocusEndReason): boolean {
    return reason === FocusEndReason.COMPLETED || reason === FocusEndReason.EARLY_FINISH;
  }
}
