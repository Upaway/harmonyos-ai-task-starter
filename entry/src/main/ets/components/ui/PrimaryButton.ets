import { AppBorder, AppColors, AppRadius, AppShadow, AppSizes, AppTypography } from '../../constants/AppTheme';

@Component
export struct PrimaryButton {
  @Prop label: string = '';
  @Prop isEnabled: boolean = true;
  onClickAction: () => void = () => {};

  build() {
    Button(this.label)
      .type(ButtonType.Normal)
      .width('100%')
      .height(AppSizes.buttonHeight)
      .borderRadius(AppSizes.buttonHeight / 2)
      .fontSize(AppTypography.buttonText)
      .fontWeight(FontWeight.Medium)
      .enabled(this.isEnabled)
      .backgroundColor(this.isEnabled ? AppColors.action : AppColors.actionSoft)
      .fontColor(this.isEnabled ? AppColors.onActionText : AppColors.secondaryText)
      .border({
        width: AppBorder.thin,
        color: this.isEnabled ? AppColors.action : AppColors.dividerSoft
      })
      .shadow(this.isEnabled ? {
        radius: 18,
        color: AppShadow.actionButton,
        offsetX: 0,
        offsetY: 8
      } : {
          radius: 0,
          color: 'rgba(0,0,0,0)',
          offsetX: 0,
          offsetY: 0
        })
      .stateStyles({
        pressed: {
          .opacity(0.88)
        },
        normal: {
          .opacity(1)
        }
      })
      .onClick(() => {
        if (this.isEnabled) {
          this.onClickAction();
        }
      });
  }
}
