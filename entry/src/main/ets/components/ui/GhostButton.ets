import { AppBorder, AppColors, AppSizes, AppTypography } from '../../constants/AppTheme';

@Component
export struct GhostButton {
  @Prop label: string = '';
  onClickAction: () => void = () => {};

  build() {
    Button(this.label)
      .type(ButtonType.Normal)
      .width('100%')
      .height(AppSizes.buttonHeightTonal)
      .borderRadius(AppSizes.buttonHeightTonal / 2)
      .fontSize(AppTypography.buttonTextSmall)
      .fontWeight(FontWeight.Regular)
      .backgroundColor(AppColors.surfaceElevated)
      .fontColor(AppColors.primaryText)
      .border({ width: AppBorder.thin, color: AppColors.dividerSoft })
      .stateStyles({
        pressed: {
          .opacity(0.88)
        },
        normal: {
          .opacity(1)
        }
      })
      .onClick(() => {
        this.onClickAction();
      });
  }
}
