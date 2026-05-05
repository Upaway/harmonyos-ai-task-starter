import {
  AppBorder,
  AppColors,
  AppLetterSpacing,
  AppLineHeight,
  AppRadius,
  AppShadow,
  AppSpacing,
  AppTypography
} from '../../constants/AppTheme';

@Component
export struct ConfirmFocusCard {
  @Prop taskQuoted: string = '';
  @Prop durationMinutes: number = 25;
  @Prop hasValidParams: boolean = true;
  @Prop hintText: string = '';

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column({ space: AppSpacing.item }) {
        Row() {
          Text('本次行动')
            .fontSize(AppTypography.tagText)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primaryText)
            .padding({
              left: AppSpacing.compact,
              right: AppSpacing.compact,
              top: 4,
              bottom: 4
            })
            .backgroundColor(AppColors.accentSoft)
            .borderRadius(AppRadius.chip);

          Blank();

          Row({ space: AppSpacing.tiny }) {
            Column()
              .width(8)
              .height(8)
              .borderRadius(4)
              .backgroundColor(AppColors.success);

            Text('准备开始')
              .fontSize(AppTypography.tagText)
              .fontColor(AppColors.secondaryText);
          }
          .alignItems(VerticalAlign.Center);
        }
        .width('100%');

        if (this.hasValidParams) {
          Text(this.taskQuoted)
            .fontSize(AppTypography.taskTitle)
            .lineHeight(AppLineHeight.taskQuoted)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primaryText)
            .maxLines(12)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .width('100%')
            .textAlign(TextAlign.Start)
            .padding({ top: AppSpacing.tiny, bottom: AppSpacing.tiny });
        } else {
          Text('未拿到有效任务参数')
            .fontSize(AppTypography.bodyText)
            .lineHeight(AppLineHeight.body)
            .fontColor(AppColors.secondaryText)
            .width('100%');
        }

        Divider()
          .strokeWidth(AppBorder.hairline)
          .color(AppColors.dividerSoft);

        Text(`${this.durationMinutes} 分钟专注`)
          .fontSize(AppTypography.sectionTitle)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.primaryText)
          .letterSpacing(AppLetterSpacing.label);

        if (this.hintText !== '') {
          Text(this.hintText)
            .fontSize(AppTypography.captionText)
            .lineHeight(AppLineHeight.caption)
            .fontColor(AppColors.secondaryText)
            .width('100%')
            .margin({ top: AppSpacing.compact });
        }
      }
      .width('100%')
      .padding(AppSpacing.cardPaddingXLarge)
      .backgroundColor(AppColors.surfaceElevated)
      .borderRadius(AppRadius.cardMain)
      .border({ width: AppBorder.thin, color: AppColors.dividerSoft });
    }
    .width('100%')
    .shadow({
      radius: AppShadow.cardRadiusBlur,
      color: AppShadow.cardColor,
      offsetX: 0,
      offsetY: AppShadow.cardOffsetY
    });
  }
}
