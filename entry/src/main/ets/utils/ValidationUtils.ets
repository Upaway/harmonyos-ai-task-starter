import { AppTexts } from '../constants/AppTexts';

export interface ValidationResult {
  valid: boolean;
  normalizedValue: string;
  message: string;
}

export class ValidationUtils {
  static validateTaskName(taskName: string): ValidationResult {
    const normalizedValue: string = taskName.trim();
    if (normalizedValue.length === 0) {
      return {
        valid: false,
        normalizedValue,
        message: AppTexts.taskValidationRequired
      };
    }

    if (normalizedValue.length > 50) {
      return {
        valid: false,
        normalizedValue,
        message: AppTexts.taskValidationTooLong
      };
    }

    return {
      valid: true,
      normalizedValue,
      message: ''
    };
  }

  static validateNote(note: string): ValidationResult {
    const normalizedValue: string = note.trim();
    if (normalizedValue.length > 100) {
      return {
        valid: false,
        normalizedValue,
        message: AppTexts.noteValidationTooLong
      };
    }

    return {
      valid: true,
      normalizedValue,
      message: ''
    };
  }
}

