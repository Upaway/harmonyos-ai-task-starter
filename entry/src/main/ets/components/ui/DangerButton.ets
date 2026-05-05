import { AppBorder, AppColors, AppSizes, AppTypography } from '../../constants/AppTheme';

@Component
export struct DangerButton {
  @Prop label: string = '';
  onClickAction: () => void = () => {};

  build() {
    Button(this.label)
      .type(ButtonType.Normal)
      .width('100%')
      .height(AppSizes.buttonHeightSmall)
      .borderRadius(AppSizes.buttonHeightSmall / 2)
      .fontSize(AppTypography.buttonTextSmall)
      .fontWeight(FontWeight.Regular)
      .backgroundColor(AppColors.dangerSoft)
      .fontColor(AppColors.danger)
      .border({ width: AppBorder.thin, color: AppColors.dangerSoft })
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
