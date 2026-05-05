import { TimeUtils } from '../utils/TimeUtils';
import { FocusDurationMinutes } from '../constants/DurationConstants';
import {
  AppColors,
  AppLetterSpacing,
  AppLineHeight,
  AppRadius,
  AppSpacing,
  AppTextLimit,
  AppTypography
} from '../constants/AppTheme';

@Component
export struct FocusTimerCard {
  @Prop taskName: string = '';
  @Prop durationMinutes: FocusDurationMinutes = 25;
  @Prop remainingSeconds: number = 0;
  @Prop isPaused: boolean = false;

  build() {
    Column({ space: AppSpacing.section }) {
      Column({ space: AppSpacing.tiny }) {
        Text('当前任务')
          .fontSize(AppTypography.meta)
          .fontColor(AppColors.onPrimaryMuted)
          .letterSpacing(AppLetterSpacing.label)
          .width('100%')
          .textAlign(TextAlign.Center);

        Column() {
          Text(`「${this.taskName}」`)
            .fontSize(AppTypography.taskTitle)
            .lineHeight(AppLineHeight.taskQuoted)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimaryText)
            .maxLines(AppTextLimit.taskCompact)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
            .textAlign(TextAlign.Center);
        }
        .width('100%')
        .padding({ top: AppSpacing.compact, bottom: AppSpacing.compact });
      }
      .width('100%');

      Text(TimeUtils.formatRemainingTime(this.remainingSeconds))
        .fontSize(AppTypography.timerDisplay)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimaryText)
        .letterSpacing(AppLetterSpacing.timer)
        .width('100%')
        .textAlign(TextAlign.Center);

      Column({ space: AppSpacing.compact }) {
        Text(this.isPaused ? '已暂停' : '保持当前节奏')
          .fontSize(AppTypography.meta)
          .fontColor(AppColors.accent)
          .width('100%')
          .textAlign(TextAlign.Center);

        Text(`本次专注 ${this.durationMinutes} 分钟`)
          .fontSize(AppTypography.meta)
          .fontColor(AppColors.onPrimaryMuted)
          .width('100%')
          .textAlign(TextAlign.Center);
      }
      .width('100%');
    }
    .width('100%')
    .padding({
      top: AppSpacing.cardPaddingXLarge,
      bottom: AppSpacing.cardPaddingXLarge,
      left: AppSpacing.cardPaddingLarge,
      right: AppSpacing.cardPaddingLarge
    })
    .backgroundColor(AppColors.primary)
    .borderRadius(AppRadius.cardHero);
  }
}
