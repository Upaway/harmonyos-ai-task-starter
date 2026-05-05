export class TimeUtils {
  static formatRemainingTime(totalSeconds: number): string {
    const safeSeconds: number = Number.isFinite(totalSeconds) ? Math.max(0, Math.floor(totalSeconds)) : 0;
    const minutes: number = Math.floor(safeSeconds / 60);
    const seconds: number = safeSeconds % 60;
    return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }

  static formatMinutesLabel(minutes: number): string {
    return `${minutes} 分钟`;
  }

  static formatDateKey(date: Date): string {
    const year: number = date.getFullYear();
    const month: string = `${date.getMonth() + 1}`.padStart(2, '0');
    const day: string = `${date.getDate()}`.padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  static formatDateTimeLabel(isoString: string): string {
    const date: Date = new Date(isoString);
    if (Number.isNaN(date.getTime())) {
      return '--';
    }

    const month: string = `${date.getMonth() + 1}`.padStart(2, '0');
    const day: string = `${date.getDate()}`.padStart(2, '0');
    const hours: string = `${date.getHours()}`.padStart(2, '0');
    const minutes: string = `${date.getMinutes()}`.padStart(2, '0');
    return `${month}-${day} ${hours}:${minutes}`;
  }

  static minutesFromSeconds(totalSeconds: number): number {
    if (!Number.isFinite(totalSeconds)) {
      return 0;
    }

    return Math.max(0, Math.floor(totalSeconds / 60));
  }

  static createSessionId(): string {
    const randomPart: number = Math.floor(Math.random() * 100000);
    return `session-${Date.now()}-${randomPart}`;
  }
}
