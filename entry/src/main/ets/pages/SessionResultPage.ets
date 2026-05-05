import { common } from '@kit.AbilityKit';
import { AppTexts } from '../constants/AppTexts';
import {
  AppBorder,
  AppColors,
  AppLineHeight,
  AppRadius,
  AppSizes,
  AppSpacing,
  AppTextLimit,
  AppTypography
} from '../constants/AppTheme';
import { DurationConstants, FocusDurationMinutes } from '../constants/DurationConstants';
import { RouteConstants } from '../constants/RouteConstants';
import { FocusEndReason, SessionResultRouteParams } from '../models/FocusSession';
import { AppPageContainer } from '../components/ui/AppPageContainer';
import { PrimaryButton } from '../components/ui/PrimaryButton';
import { TimeUtils } from '../utils/TimeUtils';
import { FocusViewModel } from '../viewmodels/FocusViewModel';

@Entry
@Component
struct SessionResultPage {
  @State private taskName: string = '';
  @State private plannedDurationMinutes: FocusDurationMinutes = DurationConstants.DEFAULT_DURATION;
  @State private actualFocusSeconds: number = 0;
  @State private endReason: FocusEndReason = FocusEndReason.ABANDONED;
  @State private startedAt: string = new Date().toISOString();
  @State private endedAt: string = new Date().toISOString();
  @State private note: string = '';
  @State private validationMessage: string = '';
  @State private hasValidParams: boolean = true;
  @State private isSaving: boolean = false;

  private focusViewModel: FocusViewModel = new FocusViewModel();

  aboutToAppear(): void {
    try {
      const router = this.getUIContext().getRouter();
      const params = router.getState();
      const paramsObj: Record<string, string | number> = params?.params as Record<string, string | number> ?? {};
      const taskName: string = typeof paramsObj.taskName === 'string' ? paramsObj.taskName.trim() : '';
      if (taskName === '') {
        this.hasValidParams = false;
        return;
      }

      const safeEndReason: FocusEndReason = paramsObj.endReason === FocusEndReason.COMPLETED
        ? FocusEndReason.COMPLETED
        : paramsObj.endReason === FocusEndReason.EARLY_FINISH
          ? FocusEndReason.EARLY_FINISH
          : FocusEndReason.ABANDONED;

      this.taskName = taskName;
      this.plannedDurationMinutes = paramsObj.plannedDurationMinutes === 50 ? 50 : 25;
      this.actualFocusSeconds = typeof paramsObj.actualFocusSeconds === 'number' ? paramsObj.actualFocusSeconds : 0;
      this.endReason = safeEndReason;
      this.startedAt = typeof paramsObj.startedAt === 'string' ? paramsObj.startedAt : new Date().toISOString();
      this.endedAt = typeof paramsObj.endedAt === 'string' ? paramsObj.endedAt : new Date().toISOString();
      this.hasValidParams = true;
    } catch (error) {
      console.error('SessionResultPage aboutToAppear error:', error);
      this.hasValidParams = false;
    }
  }

  private async saveAndGoHome(): Promise<void> {
    if (this.isSaving) {
      return;
    }

    const validationResult = this.focusViewModel.validateNote(this.note);
    if (!validationResult.valid) {
      this.validationMessage = validationResult.message;
      return;
    }

    this.validationMessage = '';
    this.isSaving = true;
    try {
      const context: common.Context = this.getUIContext().getHostContext() as common.Context;
      const router = this.getUIContext().getRouter();
      const payload: SessionResultRouteParams = {
        taskName: this.taskName,
        plannedDurationMinutes: this.plannedDurationMinutes,
        actualFocusSeconds: this.actualFocusSeconds,
        endReason: this.endReason,
        startedAt: this.startedAt,
        endedAt: this.endedAt
      };

      await this.focusViewModel.saveSession(context, {
        taskName: payload.taskName,
        plannedDurationMinutes: payload.plannedDurationMinutes,
        actualFocusSeconds: payload.actualFocusSeconds,
        endReason: payload.endReason,
        startedAt: payload.startedAt,
        endedAt: payload.endedAt,
        note: validationResult.normalizedValue
      });
      router.clear();
      await router.replaceUrl({
        url: RouteConstants.HOME_PAGE
      });
    } catch (error) {
      console.error('SessionResultPage saveAndGoHome error:', error);
    } finally {
      this.isSaving = false;
    }
  }

  build() {
    Column() {
      AppPageContainer() {
        Scroll() {
          Column({ space: AppSpacing.module }) {
            Column({ space: AppSpacing.compact }) {
              Text(this.hasValidParams ? AppTexts.getResultTitle(this.endReason) : '结果参数缺失')
                .fontSize(AppTypography.pageTitle)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.primaryText);

              Text(this.hasValidParams ? AppTexts.getResultDescription(this.endReason) : '请返回首页重新开始。')
                .fontSize(AppTypography.subtitle)
                .lineHeight(AppLineHeight.subtitle)
                .fontColor(AppColors.secondaryText);
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start);

            Column({ space: AppSpacing.item }) {
              Text(this.taskName)
                .fontSize(AppTypography.taskTitle)
                .lineHeight(AppLineHeight.taskTitle)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.primaryText)
                .maxLines(AppTextLimit.taskRelaxed)
                .textOverflow({ overflow: TextOverflow.Ellipsis });

              Text(`结束方式：${AppTexts.getReasonLabel(this.endReason)}`)
                .fontSize(AppTypography.meta)
                .fontColor(AppColors.mutedText);

              Text(`实际专注：${TimeUtils.formatRemainingTime(this.actualFocusSeconds)}`)
                .fontSize(AppTypography.meta)
                .fontColor(AppColors.mutedText);
            }
            .width('100%')
            .padding(AppSpacing.cardPaddingLarge)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppRadius.cardLarge);

            if (this.hasValidParams) {
              Column({ space: AppSpacing.content }) {
                Text('一句备注（可选）')
                  .fontSize(AppTypography.subtitle)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.primaryText);

                TextInput({
                  text: $$this.note,
                  placeholder: AppTexts.placeholderNote
                })
                  .maxLength(100)
                  .height(AppSizes.inputHeight)
                  .borderRadius(AppRadius.inputSmall)
                  .backgroundColor(AppColors.inputBackground)
                  .padding({ left: AppSpacing.inputHorizontal, right: AppSpacing.inputHorizontal })
                  .fontSize(AppTypography.body)
                  .fontColor(AppColors.primaryText)
                  .border({ width: AppBorder.thin, color: AppColors.dividerSoft });

                Text(this.validationMessage === '' ? '这句备注只保存在本地，用于回看今天做了什么。' : this.validationMessage)
                  .fontSize(AppTypography.caption)
                  .fontColor(this.validationMessage === '' ? AppColors.secondaryText : AppColors.danger);
              }
              .width('100%')
              .padding(AppSpacing.cardPadding)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppRadius.card);

              PrimaryButton({
                label: this.isSaving ? '正在保存…' : AppTexts.resultSaveButton,
                isEnabled: !this.isSaving,
                onClickAction: () => {
                  void this.saveAndGoHome();
                }
              });
            } else {
              PrimaryButton({
                label: AppTexts.backToHomeButton,
                isEnabled: true,
                onClickAction: async () => {
                  try {
                    const router = this.getUIContext().getRouter();
                    await router.replaceUrl({
                      url: RouteConstants.HOME_PAGE
                    });
                  } catch (error) {
                    console.error('SessionResultPage replaceUrl error:', error);
                  }
                }
              });
            }
          }
          .width('100%')
          .padding({
            left: AppSpacing.pageHorizontal,
            right: AppSpacing.pageHorizontal,
            top: AppSpacing.pageTop,
            bottom: AppSpacing.scrollContentBottom
          });
        }
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.Spring)
        .width('100%')
        .height('100%');
      }
    }
    .width('100%')
    .height('100%');
  }
}
