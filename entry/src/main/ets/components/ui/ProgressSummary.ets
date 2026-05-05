import {
  AppBorder,
  AppColors,
  AppLineHeight,
  AppRadius,
  AppSpacing,
  AppTypography
} from '../../constants/AppTheme';

@Component
export struct ProgressSummary {
  @Prop sessionCount: number = 0;
  @Prop totalFocusMinutes: number = 0;
  @Prop isLoading: boolean = false;

  private getProgress(): number {
    if (this.isLoading) {
      return 0.08;
    }
    const score = Math.min(1, this.sessionCount * 0.18 + this.totalFocusMinutes / 90);
    return Math.max(0.1, score);
  }

  build() {
    Column({ space: AppSpacing.content }) {
      Text(this.isLoading ? '正在同步今日进度…' : '今天已经开始，就是进步。')
        .fontSize(AppTypography.captionText)
        .lineHeight(AppLineHeight.caption)
        .fontColor(AppColors.mutedText)
        .width('100%')
        .textAlign(TextAlign.Center);

      Row({ space: AppSpacing.section }) {
        Column({ space: AppSpacing.tiny }) {
          Text('今日次数')
            .fontSize(AppTypography.tagText)
            .fontColor(AppColors.secondaryText);
          Text(`${this.sessionCount}`)
            .fontSize(AppTypography.sectionTitle)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primaryText);
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start);

        Column({ space: AppSpacing.tiny }) {
          Text('累计分钟')
            .fontSize(AppTypography.tagText)
            .fontColor(AppColors.secondaryText);
          Text(`${this.totalFocusMinutes}`)
            .fontSize(AppTypography.sectionTitle)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primaryText);
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start);
      }
      .width('100%');

      Row() {
        Blank().layoutWeight(1 - this.getProgress());

        Row()
          .layoutWeight(this.getProgress())
          .height(6)
          .backgroundColor(AppColors.accent)
          .borderRadius(AppRadius.pill);
      }
      .width('100%')
      .height(6)
      .padding(0)
      .backgroundColor(AppColors.actionSoft)
      .borderRadius(AppRadius.pill);
    }
    .width('100%')
    .padding({
      left: AppSpacing.cardPaddingLarge,
      right: AppSpacing.cardPaddingLarge,
      top: AppSpacing.cardPadding,
      bottom: AppSpacing.cardPadding
    })
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.card)
    .border({ width: AppBorder.thin, color: AppColors.dividerSoft });
  }
}
