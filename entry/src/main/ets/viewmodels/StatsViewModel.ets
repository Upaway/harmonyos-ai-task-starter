import { common } from '@kit.AbilityKit';
import { DailyStats } from '../models/DailyStats';
import { FocusSession } from '../models/FocusSession';
import { UserPreference } from '../models/UserPreference';
import { SessionRepository } from '../storage/SessionRepository';
import { PreferenceRepository } from '../storage/PreferenceRepository';
import { StatsUtils } from '../utils/StatsUtils';

export interface StatsPageData {
  dailyStats: DailyStats;
  preference: UserPreference;
  recentSessions: FocusSession[];
}

export class StatsViewModel {
  private sessionRepository: SessionRepository = new SessionRepository();
  private preferenceRepository: PreferenceRepository = new PreferenceRepository();

  async loadStatsPageData(context: common.Context): Promise<StatsPageData> {
    const sessions = await this.sessionRepository.listSessions(context);
    const preference = await this.preferenceRepository.getPreferences(context);
    return {
      dailyStats: StatsUtils.buildDailyStats(sessions),
      preference,
      recentSessions: StatsUtils.buildRecentSessions(sessions, 10)
    };
  }
}

