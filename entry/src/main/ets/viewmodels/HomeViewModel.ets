import { common } from '@kit.AbilityKit';
import { DailyStats } from '../models/DailyStats';
import { UserPreference } from '../models/UserPreference';
import { SessionRepository } from '../storage/SessionRepository';
import { PreferenceRepository } from '../storage/PreferenceRepository';
import { StatsUtils } from '../utils/StatsUtils';
import { ValidationResult, ValidationUtils } from '../utils/ValidationUtils';

export interface HomeScreenData {
  dailyStats: DailyStats;
  preference: UserPreference;
}

export class HomeViewModel {
  private sessionRepository: SessionRepository = new SessionRepository();
  private preferenceRepository: PreferenceRepository = new PreferenceRepository();

  async loadHomeScreenData(context: common.Context): Promise<HomeScreenData> {
    const sessions = await this.sessionRepository.listSessions(context);
    const preference = await this.preferenceRepository.getPreferences(context);
    return {
      dailyStats: StatsUtils.buildDailyStats(sessions),
      preference
    };
  }

  validateTaskName(taskName: string): ValidationResult {
    return ValidationUtils.validateTaskName(taskName);
  }
}

