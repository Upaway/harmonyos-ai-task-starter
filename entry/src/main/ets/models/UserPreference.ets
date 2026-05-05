import { FocusDurationMinutes } from '../constants/DurationConstants';

export interface UserPreference {
  defaultDurationMinutes: FocusDurationMinutes;
  reminderEnabled: boolean;
  aiEnabled: boolean;
}

