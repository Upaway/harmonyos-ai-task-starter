import { common } from '@kit.AbilityKit';
import { AppTexts } from '../constants/AppTexts';
import { AppColors, AppLineHeight, AppSpacing, AppTypography } from '../constants/AppTheme';
import { DurationConstants, FocusDurationMinutes } from '../constants/DurationConstants';
import { RouteConstants } from '../constants/RouteConstants';
import { ActionCard } from '../components/ui/ActionCard';
import { AppHeroHeader } from '../components/ui/AppHeroHeader';
import { AppPageContainer } from '../components/ui/AppPageContainer';
import { DurationSegment } from '../components/ui/DurationSegment';
import { PrimaryButton } from '../components/ui/PrimaryButton';
import { ProgressSummary } from '../components/ui/ProgressSummary';
import { HomeViewModel } from '../viewmodels/HomeViewModel';

@Entry
@Component
struct HomePage {
  @State private taskName: string = '';
  @State private selectedDuration: FocusDurationMinutes = DurationConstants.DEFAULT_DURATION;
  @State private validationMessage: string = '';
  @State private sessionCount: number = 0;
  @State private totalFocusMinutes: number = 0;
  @State private isLoading: boolean = true;

  private homeViewModel: HomeViewModel = new HomeViewModel();

  aboutToAppear(): void {
    void this.loadPageData();
  }

  private async loadPageData(): Promise<void> {
    try {
      this.isLoading = true;
      const context: common.Context = this.getUIContext().getHostContext() as common.Context;
      const pageData = await this.homeViewModel.loadHomeScreenData(context);
      this.selectedDuration = pageData.preference.defaultDurationMinutes;
      this.sessionCount = pageData.dailyStats.sessionCount;
      this.totalFocusMinutes = pageData.dailyStats.totalFocusMinutes;
    } catch (error) {
      console.error('HomePage loadPageData error:', error);
    } finally {
      this.isLoading = false;
    }
  }

  private canStart(): boolean {
    return this.homeViewModel.validateTaskName(this.taskName).valid;
  }

  private getTaskMessage(): string {
    if (this.validationMessage !== '') {
      return this.validationMessage;
    }

    return AppTexts.homeTaskHelper;
  }

  private getPrimaryLabel(): string {
    return this.canStart() ? '开始做事' : '先写下一件事';
  }

  private async startFocusFlow(): Promise<void> {
    const validationResult = this.homeViewModel.validateTaskName(this.taskName);
    if (!validationResult.valid) {
      this.validationMessage = validationResult.message;
      return;
    }

    this.validationMessage = '';
    try {
      const router = this.getUIContext().getRouter();
      await router.pushUrl({
        url: RouteConstants.START_CONFIRM_PAGE,
        params: {
          taskName: validationResult.normalizedValue,
          durationMinutes: this.selectedDuration
        }
      });
    } catch (error) {
      console.error('HomePage startFocusFlow error:', error);
    }
  }

  build() {
    Column() {
      AppPageContainer() {
      Scroll() {
        Column({ space: AppSpacing.module }) {
          AppHeroHeader({
            title: AppTexts.appName,
            subtitle: AppTexts.homeSubtitle,
            moodLine: AppTexts.homeMoodLine
          });

          ActionCard({
            taskName: $taskName,
            helperText: this.getTaskMessage(),
            errorText: this.validationMessage
          });

          DurationSegment({
            selectedDuration: $selectedDuration
          });

          PrimaryButton({
            label: this.getPrimaryLabel(),
            isEnabled: this.canStart(),
            onClickAction: () => {
              void this.startFocusFlow();
            }
          });

          ProgressSummary({
            sessionCount: this.sessionCount,
            totalFocusMinutes: this.totalFocusMinutes,
            isLoading: this.isLoading
          });

          Text('查看统计与设置 →')
            .fontSize(AppTypography.captionText)
            .lineHeight(AppLineHeight.caption)
            .fontColor(AppColors.mutedText)
            .width('100%')
            .textAlign(TextAlign.Center)
            .padding({ top: AppSpacing.compact, bottom: 0 })
            .onClick(async () => {
              try {
                const router = this.getUIContext().getRouter();
                await router.pushUrl({
                  url: RouteConstants.STATS_SETTINGS_PAGE
                });
                await this.loadPageData();
              } catch (error) {
                console.error('HomePage navigate combined error:', error);
              }
            });
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
