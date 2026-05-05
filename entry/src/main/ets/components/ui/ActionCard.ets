import { AppTexts } from '../../constants/AppTexts';
import {
  AppBorder,
  AppColors,
  AppLineHeight,
  AppRadius,
  AppShadow,
  AppSizes,
  AppSpacing,
  AppTypography
} from '../../constants/AppTheme';

@Component
export struct ActionCard {
  @Link taskName: string;
  @Prop helperText: string = '';
  @Prop errorText: string = '';

  private isReady(): boolean {
    return this.taskName.trim().length > 0;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column({ space: AppSpacing.item }) {
        Row({ space: AppSpacing.compact }) {
          Text('今日行动')
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

          if (this.isReady()) {
            Text('已就绪')
              .fontSize(AppTypography.tagText)
              .fontColor(AppColors.success)
              .padding({
                left: AppSpacing.compact,
                right: AppSpacing.compact,
                top: 4,
                bottom: 4
              })
              .backgroundColor(AppColors.actionSoft)
              .borderRadius(AppRadius.chip);
          }
        }
        .width('100%');

        Row({ space: AppSpacing.content }) {
          Text('✦')
            .fontSize(20)
            .fontColor(AppColors.accent)
            .opacity(0.85);

          Text('现在想开始什么？')
            .fontSize(AppTypography.sectionTitle)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primaryText)
            .layoutWeight(1);
        }
        .width('100%')
        .alignItems(VerticalAlign.Center);

        TextInput({
          text: $$this.taskName,
          placeholder: AppTexts.placeholderTask
        })
          .maxLength(50)
          .height(AppSizes.inputHeight)
          .borderRadius(AppRadius.input)
          .backgroundColor(this.isReady() ? AppColors.surfaceElevated : AppColors.inputBackground)
          .padding({ left: AppSpacing.inputHorizontal, right: AppSpacing.inputHorizontal })
          .fontSize(AppTypography.bodyText)
          .fontColor(AppColors.primaryText)
          .border({
            width: AppBorder.thin,
            color: this.errorText !== '' ? AppColors.dangerSoft : AppColors.dividerSoft
          });

        Text(this.errorText !== '' ? this.errorText : this.helperText)
          .fontSize(AppTypography.captionText)
          .lineHeight(AppLineHeight.caption)
          .fontColor(this.errorText !== '' ? AppColors.danger : AppColors.secondaryText)
          .width('100%');
      }
      .width('100%')
      .padding(AppSpacing.cardPaddingXLarge)
      .backgroundColor(AppColors.surfaceElevated)
      .borderRadius(AppRadius.cardMain)
      .border({
        width: AppBorder.thin,
        color: this.isReady() ? AppColors.accentSoft : AppColors.dividerSoft
      });
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
