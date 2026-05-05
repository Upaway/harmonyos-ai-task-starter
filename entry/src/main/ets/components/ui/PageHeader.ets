import { AppColors, AppLineHeight, AppSpacing, AppTypography } from '../../constants/AppTheme';

@Component
export struct PageHeader {
  @Prop title: string = '';
  @Prop subtitle: string = '';

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width(72)
        .height(72)
        .borderRadius(36)
        .backgroundColor(AppColors.accentSoft)
        .opacity(0.45)
        .position({ x: '78%', y: -8 });

      Column({ space: AppSpacing.compact }) {
        Text(this.title)
          .fontSize(AppTypography.pageTitle)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primaryText)
          .width('100%');

        Text(this.subtitle)
          .fontSize(AppTypography.pageSubtitle)
          .lineHeight(AppLineHeight.pageSubtitle)
          .fontColor(AppColors.secondaryText)
          .width('100%');
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start);
    }
    .width('100%');
  }
}
