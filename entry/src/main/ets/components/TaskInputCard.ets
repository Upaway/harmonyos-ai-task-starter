import { AppTexts } from '../constants/AppTexts';
import { AppBorder, AppColors, AppLineHeight, AppRadius, AppSizes, AppSpacing, AppTypography } from '../constants/AppTheme';

@Component
export struct TaskInputCard {
  @Link taskName: string;
  @Prop helperText: string = '';
  @Prop errorText: string = '';

  build() {
    Column({ space: AppSpacing.item }) {
      Text('现在想开始什么？')
        .fontSize(AppTypography.bodyLarge)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primaryText);

      TextInput({
        text: $$this.taskName,
        placeholder: AppTexts.placeholderTask
      })
        .maxLength(50)
        .height(AppSizes.inputHeight)
        .borderRadius(AppRadius.input)
        .backgroundColor(AppColors.inputBackground)
        .padding({ left: AppSpacing.inputHorizontal, right: AppSpacing.inputHorizontal })
        .fontSize(AppTypography.body)
        .fontColor(AppColors.primaryText)
        .border({ width: AppBorder.thin, color: AppColors.divider });

      Text(this.errorText !== '' ? this.errorText : this.helperText)
        .fontSize(AppTypography.helper)
        .lineHeight(AppLineHeight.helper)
        .fontColor(this.errorText !== '' ? AppColors.danger : AppColors.secondaryText);
    }
    .width('100%')
    .padding(AppSpacing.cardPaddingLarge)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.cardLarge);
  }
}
