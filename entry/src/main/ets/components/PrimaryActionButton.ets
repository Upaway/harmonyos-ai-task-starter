import { AppColors, AppRadius, AppSizes, AppTypography } from '../constants/AppTheme';

@Component
export struct PrimaryActionButton {
  @Prop label: string = '';
  @Prop isEnabled: boolean = true;
  onClickAction: () => void = () => {};

  build() {
    Button(this.label)
      .width('100%')
      .height(AppSizes.buttonHeight)
      .enabled(this.isEnabled)
      .borderRadius(AppRadius.button)
      .fontSize(AppTypography.button)
      .fontWeight(FontWeight.Medium)
      .backgroundColor(this.isEnabled ? AppColors.action : AppColors.disabled)
      .fontColor(this.isEnabled ? AppColors.onActionText : AppColors.primaryText)
      .onClick(() => {
        if (this.isEnabled) {
          this.onClickAction();
        }
      });
  }
}
