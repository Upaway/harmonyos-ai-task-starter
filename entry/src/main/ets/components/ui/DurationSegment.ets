import { DurationConstants, FocusDurationMinutes } from '../../constants/DurationConstants';
import {
  AppColors,
  AppRadius,
  AppSizes,
  AppSpacing,
  AppTypography
} from '../../constants/AppTheme';

@Component
export struct DurationSegment {
  @Link selectedDuration: FocusDurationMinutes;

  build() {
    Column({ space: AppSpacing.content }) {
      Text('选择专注时长')
        .fontSize(AppTypography.sectionTitle)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondaryText)
        .width('100%');

      Row() {
        ForEach(DurationConstants.OPTIONS, (duration: FocusDurationMinutes) => {
          Button(`${duration} 分钟`)
            .type(ButtonType.Normal)
            .layoutWeight(1)
            .height(AppSizes.segmentHeight - 4)
            .borderRadius(AppRadius.pill)
            .fontSize(AppTypography.buttonTextSmall)
            .fontWeight(this.selectedDuration === duration ? FontWeight.Medium : FontWeight.Regular)
            .backgroundColor(this.selectedDuration === duration ? AppColors.action : 'rgba(0,0,0,0)')
            .fontColor(this.selectedDuration === duration ? AppColors.onActionText : AppColors.secondaryText)
            .stateStyles({
              pressed: {
                .opacity(0.88)
              },
              normal: {
                .opacity(1)
              }
            })
            .onClick(() => {
              this.selectedDuration = duration;
            });
        }, (duration: FocusDurationMinutes) => `${duration}`);
      }
      .width('100%')
      .padding(AppSpacing.controlInset)
      .backgroundColor(AppColors.actionSoft)
      .borderRadius(AppRadius.card)
      .border({ width: 1, color: AppColors.dividerSoft });
    }
    .width('100%');
  }
}
