import { TimeUtils } from '../../utils/TimeUtils';
import { FocusDurationMinutes } from '../../constants/DurationConstants';
import {
  AppColors,
  AppLetterSpacing,
  AppLineHeight,
  AppRadius,
  AppSpacing,
  AppTextLimit,
  AppTypography
} from '../../constants/AppTheme';

@Component
export struct FocusTimerPanel {
  @Prop taskName: string = '';
  @Prop durationMinutes: FocusDurationMinutes = 25;
  @Prop remainingSeconds: number = 0;
  @Prop isPaused: boolean = false;

  build() {
    Column({ space: AppSpacing.section }) {
      Text('当前任务')
        .fontSize(AppTypography.timerMeta)
        .fontColor(AppColors.onPrimaryMuted)
        .letterSpacing(AppLetterSpacing.label)
        .width('100%')
        .textAlign(TextAlign.Center);

      Text(`「${this.taskName}」`)
        .fontSize(AppTypography.taskTitle)
        .lineHeight(AppLineHeight.taskQuoted)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimaryText)
        .maxLines(AppTextLimit.taskCompact)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ left: AppSpacing.compact, right: AppSpacing.compact });

      Text(TimeUtils.formatRemainingTime(this.remainingSeconds))
        .fontSize(AppTypography.timerNumber)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimaryText)
        .letterSpacing(AppLetterSpacing.timer)
        .width('100%')
        .textAlign(TextAlign.Center)
        .margin({ top: AppSpacing.compact, bottom: AppSpacing.compact });

      Text(this.isPaused ? '已暂停' : '保持当前节奏')
        .fontSize(AppTypography.timerMeta)
        .fontColor(AppColors.accent)
        .width('100%')
        .textAlign(TextAlign.Center);

      Text(`本次专注 · ${this.durationMinutes} 分钟`)
        .fontSize(AppTypography.timerMeta)
        .fontColor(AppColors.onPrimaryMuted)
        .width('100%')
        .textAlign(TextAlign.Center);
    }
    .width('100%')
    .padding({
      top: AppSpacing.cardPaddingXLarge,
      bottom: AppSpacing.cardPaddingXLarge,
      left: AppSpacing.cardPaddingLarge,
      right: AppSpacing.cardPaddingLarge
    })
    .linearGradient({
      angle: 165,
      colors: [['#161F26', 0.0], ['#2C3B47', 1.0]]
    })
    .borderRadius(AppRadius.cardFloat)
    .shadow({
      radius: 28,
      color: 'rgba(12, 18, 22, 0.38)',
      offsetX: 0,
      offsetY: 18
    });
  }
}
