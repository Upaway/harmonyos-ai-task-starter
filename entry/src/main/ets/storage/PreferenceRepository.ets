import { common } from '@kit.AbilityKit';
import { DurationConstants } from '../constants/DurationConstants';
import { UserPreference } from '../models/UserPreference';
import { LocalStorageService } from './LocalStorageService';

export class PreferenceRepository {
  private static readonly STORAGE_KEY: string = 'user_preference';
  private localStorageService: LocalStorageService = LocalStorageService.getInstance();

  async getPreferences(context: common.Context): Promise<UserPreference> {
    const rawValue: string = await this.localStorageService.getString(
      context,
      PreferenceRepository.STORAGE_KEY,
      ''
    );

    if (rawValue === '') {
      return PreferenceRepository.getDefaultPreference();
    }

    try {
      const parsedValue: Record<string, string | number | boolean> =
        JSON.parse(rawValue) as Record<string, string | number | boolean>;
      return {
        defaultDurationMinutes: parsedValue.defaultDurationMinutes === 50 ? 50 : DurationConstants.DEFAULT_DURATION,
        reminderEnabled: parsedValue.reminderEnabled === true,
        aiEnabled: parsedValue.aiEnabled === true
      };
    } catch (_error) {
      return PreferenceRepository.getDefaultPreference();
    }
  }

  async savePreferences(context: common.Context, preferencesValue: UserPreference): Promise<void> {
    await this.localStorageService.putString(
      context,
      PreferenceRepository.STORAGE_KEY,
      JSON.stringify(preferencesValue)
    );
  }

  static getDefaultPreference(): UserPreference {
    return {
      defaultDurationMinutes: DurationConstants.DEFAULT_DURATION,
      reminderEnabled: false,
      aiEnabled: false
    };
  }
}

