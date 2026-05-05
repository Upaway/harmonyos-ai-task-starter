import { common } from '@kit.AbilityKit';
import { FocusDurationMinutes } from '../constants/DurationConstants';
import { UserPreference } from '../models/UserPreference';
import { PreferenceRepository } from '../storage/PreferenceRepository';

export class SettingsViewModel {
  private preferenceRepository: PreferenceRepository = new PreferenceRepository();

  async loadPreferences(context: common.Context): Promise<UserPreference> {
    return this.preferenceRepository.getPreferences(context);
  }

  async updateDefaultDuration(context: common.Context, durationMinutes: FocusDurationMinutes): Promise<UserPreference> {
    const currentPreference: UserPreference = await this.preferenceRepository.getPreferences(context);
    const updatedPreference: UserPreference = {
      reminderEnabled: currentPreference.reminderEnabled,
      aiEnabled: currentPreference.aiEnabled,
      defaultDurationMinutes: durationMinutes
    };
    await this.preferenceRepository.savePreferences(context, updatedPreference);
    return updatedPreference;
  }

  async updateReminder(context: common.Context, enabled: boolean): Promise<UserPreference> {
    const currentPreference: UserPreference = await this.preferenceRepository.getPreferences(context);
    const updatedPreference: UserPreference = {
      defaultDurationMinutes: currentPreference.defaultDurationMinutes,
      reminderEnabled: enabled,
      aiEnabled: currentPreference.aiEnabled
    };
    await this.preferenceRepository.savePreferences(context, updatedPreference);
    return updatedPreference;
  }

  async updateAiSwitch(context: common.Context, enabled: boolean): Promise<UserPreference> {
    const currentPreference: UserPreference = await this.preferenceRepository.getPreferences(context);
    const updatedPreference: UserPreference = {
      defaultDurationMinutes: currentPreference.defaultDurationMinutes,
      reminderEnabled: currentPreference.reminderEnabled,
      aiEnabled: enabled
    };
    await this.preferenceRepository.savePreferences(context, updatedPreference);
    return updatedPreference;
  }
}
