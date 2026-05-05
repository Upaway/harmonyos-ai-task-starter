import { AppColors, AppLineHeight, AppRadius, AppSpacing, AppTypography } from '../constants/AppTheme';

@Component
export struct StatsSummaryCard {
  @Prop sessionCount: number = 0;
  @Prop totalFocusMinutes: number = 0;

  build() {
    Column({ space: AppSpacing.content }) {
      Text('今天已经推进')
        .fontSize(AppTypography.cardTitle)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primaryText);

      Text('不用追求很多，能推进一次就算开始。')
        .fontSize(AppTypography.helper)
        .lineHeight(AppLineHeight.helper)
        .fontColor(AppColors.secondaryText);

      Row() {
        Column({ space: AppSpacing.tiny }) {
          Text(`${this.sessionCount}`)
            .fontSize(AppTypography.statNumber)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primaryText);
          Text('次数')
            .fontSize(AppTypography.helper)
            .fontColor(AppColors.secondaryText);
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1);

        Column({ space: AppSpacing.tiny }) {
          Text(`${this.totalFocusMinutes}`)
            .fontSize(AppTypography.statNumber)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primaryText);
          Text('分钟')
            .fontSize(AppTypography.helper)
            .fontColor(AppColors.secondaryText);
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1);
      }
      .width('100%');
    }
    .width('100%')
    .padding(AppSpacing.cardPaddingLarge)
    .backgroundColor(AppColors.surfaceSoft)
    .borderRadius(AppRadius.cardLarge);
  }
}
