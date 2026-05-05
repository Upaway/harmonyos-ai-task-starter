import { common } from '@kit.AbilityKit';
import { FocusEndReason, FocusSession } from '../models/FocusSession';
import { LocalStorageService } from './LocalStorageService';
import { StatsUtils } from '../utils/StatsUtils';

export class SessionRepository {
  private static readonly STORAGE_KEY: string = 'focus_sessions';
  private localStorageService: LocalStorageService = LocalStorageService.getInstance();

  async saveSession(context: common.Context, session: FocusSession): Promise<void> {
    const sessions: FocusSession[] = await this.listSessions(context);
    sessions.unshift(session);
    await this.localStorageService.putString(
      context,
      SessionRepository.STORAGE_KEY,
      JSON.stringify(StatsUtils.sortSessionsByEndedAtDesc(sessions))
    );
  }

  async listSessions(context: common.Context): Promise<FocusSession[]> {
    const rawValue: string = await this.localStorageService.getString(
      context,
      SessionRepository.STORAGE_KEY,
      '[]'
    );

    let parsedValue: Array<Object | null> = [];
    try {
      parsedValue = JSON.parse(rawValue) as Array<Object | null>;
    } catch (_error) {
      parsedValue = [];
    }

    if (!Array.isArray(parsedValue)) {
      return [];
    }

    return StatsUtils.sortSessionsByEndedAtDesc(
      parsedValue
        .filter((item: Object | null): boolean => item !== null)
        .map((item: Object | null) => this.normalizeSession(item as Object))
    );
  }

  async listTodaySessions(context: common.Context, dateKey: string): Promise<FocusSession[]> {
    const sessions: FocusSession[] = await this.listSessions(context);
    return sessions.filter((item: FocusSession) => item.dateKey === dateKey);
  }

  private normalizeSession(rawValue: Object): FocusSession {
    const source: Record<string, string | number> = rawValue as Record<string, string | number>;
    const endReasonValue: string = typeof source.endReason === 'string'
      ? source.endReason
      : FocusEndReason.ABANDONED;

    const safeEndReason: FocusEndReason = endReasonValue === FocusEndReason.COMPLETED
      ? FocusEndReason.COMPLETED
      : endReasonValue === FocusEndReason.EARLY_FINISH
        ? FocusEndReason.EARLY_FINISH
        : FocusEndReason.ABANDONED;

    return {
      id: typeof source.id === 'string' ? source.id : '',
      taskName: typeof source.taskName === 'string' ? source.taskName : '',
      plannedDurationMinutes: source.plannedDurationMinutes === 50 ? 50 : 25,
      actualFocusSeconds: typeof source.actualFocusSeconds === 'number' ? source.actualFocusSeconds : 0,
      endReason: safeEndReason,
      note: typeof source.note === 'string' ? source.note : '',
      startedAt: typeof source.startedAt === 'string' ? source.startedAt : new Date().toISOString(),
      endedAt: typeof source.endedAt === 'string' ? source.endedAt : new Date().toISOString(),
      dateKey: typeof source.dateKey === 'string' ? source.dateKey : ''
    };
  }
}
