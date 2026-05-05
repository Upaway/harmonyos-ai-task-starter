import { AppColors, AppLineHeight, AppSpacing, AppTypography } from '../../constants/AppTheme';

@Component
export struct AppHeroHeader {
  @Prop title: string = '';
  @Prop subtitle: string = '';
  @Prop moodLine: string = '';

  build() {
    Column({ space: AppSpacing.section }) {
      Row({ space: AppSpacing.content }) {
        Column()
          .width(3)
          .height(40)
          .borderRadius(2)
          .linearGradient({
            angle: 180,
            colors: [[AppColors.accent, 0.0], ['#D4A574', 1.0]]
          });

        Column({ space: AppSpacing.compact }) {
          Text(this.title)
            .fontSize(AppTypography.heroTitle)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.primaryText)
            .lineHeight(AppLineHeight.heroTitle)
            .width('100%');

          Text(this.subtitle)
            .fontSize(AppTypography.pageSubtitle)
            .lineHeight(AppLineHeight.pageSubtitle)
            .fontColor(AppColors.secondaryText)
            .width('100%');

          if (this.moodLine !== '') {
            Text(this.moodLine)
              .fontSize(AppTypography.captionText)
              .lineHeight(AppLineHeight.caption)
              .fontColor(AppColors.mutedText)
              .width('100%')
              .margin({ top: AppSpacing.tiny });
          }
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start);
      }
      .width('100%')
      .alignItems(VerticalAlign.Top);

      Row()
        .width('100%')
        .height(1)
        .backgroundColor(AppColors.dividerSoft);
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ top: 2, bottom: AppSpacing.compact });
  }
}
