import { DailyStats } from '../models/DailyStats';
import { FocusSession } from '../models/FocusSession';
import { TimeUtils } from './TimeUtils';

export class StatsUtils {
  static buildDailyStats(sessions: FocusSession[], date: Date = new Date()): DailyStats {
    const dateKey: string = TimeUtils.formatDateKey(date);
    return StatsUtils.buildDailyStatsByDateKey(sessions, dateKey);
  }

  static buildDailyStatsByDateKey(sessions: FocusSession[], dateKey: string): DailyStats {
    const todaySessions: FocusSession[] = StatsUtils.sortSessionsByEndedAtDesc(
      sessions.filter((item: FocusSession) => item.dateKey === dateKey)
    );

    const totalFocusMinutes: number = todaySessions.reduce((total: number, item: FocusSession) => {
      return total + TimeUtils.minutesFromSeconds(item.actualFocusSeconds);
    }, 0);

    return {
      dateKey,
      sessionCount: todaySessions.length,
      totalFocusMinutes
    };
  }

  static buildRecentSessions(sessions: FocusSession[], limit: number = 10): FocusSession[] {
    return StatsUtils.sortSessionsByEndedAtDesc(sessions).slice(0, limit);
  }

  static sortSessionsByEndedAtDesc(sessions: FocusSession[]): FocusSession[] {
    return [...sessions].sort((left: FocusSession, right: FocusSession) => {
      return new Date(right.endedAt).getTime() - new Date(left.endedAt).getTime();
    });
  }
}
