import { FocusDurationMinutes } from '../constants/DurationConstants';

export enum FocusEndReason {
  COMPLETED = 'COMPLETED',
  EARLY_FINISH = 'EARLY_FINISH',
  ABANDONED = 'ABANDONED'
}

export interface FocusSession {
  id: string;
  taskName: string;
  plannedDurationMinutes: FocusDurationMinutes;
  actualFocusSeconds: number;
  endReason: FocusEndReason;
  note: string;
  startedAt: string;
  endedAt: string;
  dateKey: string;
}

export interface SessionResultRouteParams {
  taskName: string;
  plannedDurationMinutes: FocusDurationMinutes;
  actualFocusSeconds: number;
  endReason: FocusEndReason;
  startedAt: string;
  endedAt: string;
}

