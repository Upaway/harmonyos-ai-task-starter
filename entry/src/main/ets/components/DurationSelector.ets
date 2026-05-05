import { FocusDurationMinutes } from '../constants/DurationConstants';
import { AppBorder, AppColors, AppRadius, AppShadow, AppSpacing } from '../constants/AppTheme';
import { DurationSegment } from './ui/DurationSegment';

@Component
export struct DurationSelector {
  @Link selectedDuration: FocusDurationMinutes;

  build() {
    Column({ space: AppSpacing.content }) {
      DurationSegment({
        selectedDuration: $selectedDuration
      });
    }
    .width('100%')
    .padding(AppSpacing.cardPadding)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.card)
    .border({ width: AppBorder.thin, color: AppColors.dividerSoft })
    .shadow({
      radius: AppShadow.cardRadiusBlur,
      color: AppShadow.cardColor,
      offsetX: 0,
      offsetY: 6
    });
  }
}
