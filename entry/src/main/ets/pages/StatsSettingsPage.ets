import { common } from '@kit.AbilityKit';
import { AppTexts } from '../constants/AppTexts';
import {
  AppColors,
  AppLineHeight,
  AppRadius,
  AppSizes,
  AppSpacing,
  AppTextLimit,
  AppTypography
} from '../constants/AppTheme';
import { DurationConstants, FocusDurationMinutes } from '../constants/DurationConstants';
import { FocusEndReason, FocusSession } from '../models/FocusSession';
import { AppPageContainer } from '../components/ui/AppPageContainer';
import { StatsSummaryCard } from '../components/StatsSummaryCard';
import { DurationSelector } from '../components/DurationSelector';
import { TimeUtils } from '../utils/TimeUtils';
import { SettingsViewModel } from '../viewmodels/SettingsViewModel';
import { StatsViewModel } from '../viewmodels/StatsViewModel';

@Entry
@Component
struct StatsSettingsPage {
  @State private selectedDuration: FocusDurationMinutes = DurationConstants.DEFAULT_DURATION;
  @State private sessionCount: number = 0;
  @State private totalFocusMinutes: number = 0;
  @State private recentSessions: FocusSession[] = [];
  @State private statusMessage: string = '';

  private statsViewModel: StatsViewModel = new StatsViewModel();
  private settingsViewModel: SettingsViewModel = new SettingsViewModel();

  aboutToAppear(): void {
    void this.loadPageData();
  }

  private async loadPageData(): Promise<void> {
    try {
      const context: common.Context = this.getUIContext().getHostContext() as common.Context;
      const pageData = await this.statsViewModel.loadStatsPageData(context);
      this.selectedDuration = pageData.preference.defaultDurationMinutes;
      this.sessionCount = pageData.dailyStats.sessionCount;
      this.totalFocusMinutes = pageData.dailyStats.totalFocusMinutes;
      this.recentSessions = pageData.recentSessions;
      this.statusMessage = '';
    } catch (error) {
      console.error('StatsSettingsPage loadPageData error:', error);
      this.statusMessage = '加载数据失败，请重试。';
    }
  }

  private async saveDefaultDuration(): Promise<void> {
    try {
      const context: common.Context = this.getUIContext().getHostContext() as common.Context;
      const updatedPreference = await this.settingsViewModel.updateDefaultDuration(context, this.selectedDuration);
      this.selectedDuration = updatedPreference.defaultDurationMinutes;
      this.statusMessage = `默认时长已更新为 ${this.selectedDuration} 分钟。`;
    } catch (error) {
      console.error('StatsSettingsPage saveDefaultDuration error:', error);
      this.statusMessage = '保存失败，请重试。';
    }
  }

  build() {
    Column() {
      AppPageContainer() {
        Scroll() {
          Column({ space: AppSpacing.module }) {
        Row() {
          Column({ space: AppSpacing.tiny }) {
            Text(AppTexts.statsTitle)
              .fontSize(AppTypography.pageTitle)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppColors.primaryText);

            Text('看见已经推进的部分，再决定下一步。')
              .fontSize(AppTypography.helper)
              .lineHeight(AppLineHeight.helper)
              .fontColor(AppColors.secondaryText);
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start);

          Button('返回')
            .type(ButtonType.Normal)
            .height(AppSizes.tagHeight)
            .padding({ left: AppSpacing.tagHorizontal, right: AppSpacing.tagHorizontal })
            .borderRadius(AppRadius.tag)
            .backgroundColor(AppColors.controlSoft)
            .fontColor(AppColors.primaryText)
            .fontSize(AppTypography.tag)
            .stateStyles({
              pressed: {
                .opacity(0.88)
              },
              normal: {
                .opacity(1)
              }
            })
            .onClick(() => {
              try {
                const router = this.getUIContext().getRouter();
                router.back();
              } catch (error) {
                console.error('StatsSettingsPage back error:', error);
              }
            });
        }
        .width('100%');

        StatsSummaryCard({
          sessionCount: this.sessionCount,
          totalFocusMinutes: this.totalFocusMinutes
        });

        if (this.recentSessions.length === 0) {
          Text(AppTexts.statsRecentEmpty)
            .width('100%')
            .padding(AppSpacing.cardPaddingMedium)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppRadius.card)
            .fontSize(AppTypography.meta)
            .lineHeight(AppLineHeight.body)
            .fontColor(AppColors.secondaryText);
        } else {
          Column({ space: AppSpacing.content }) {
            Text(AppTexts.recentSessionsTitle)
              .fontSize(AppTypography.cardTitle)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.primaryText);

            ForEach(this.recentSessions, (item: FocusSession) => {
              Column({ space: AppSpacing.compact }) {
                Row({ space: AppSpacing.compact }) {
                  Text(item.taskName)
                    .fontSize(AppTypography.cardTitle)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primaryText)
                    .maxLines(AppTextLimit.taskCompact)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .layoutWeight(1);

                  Text(AppTexts.getSessionStatusTag(item.endReason))
                    .fontSize(AppTypography.tagText)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(item.endReason === FocusEndReason.ABANDONED ? AppColors.danger : AppColors.success)
                    .padding({
                      left: AppSpacing.compact,
                      right: AppSpacing.compact,
                      top: 4,
                      bottom: 4
                    })
                    .backgroundColor(item.endReason === FocusEndReason.ABANDONED ? AppColors.dangerSoft : AppColors.accentSoft)
                    .borderRadius(AppRadius.chip);
                }
                .width('100%')
                .alignItems(VerticalAlign.Top);

                Text(
                  `计划 ${item.plannedDurationMinutes} 分钟 · 实际 ${TimeUtils.minutesFromSeconds(item.actualFocusSeconds)} 分钟 · ${TimeUtils.formatDateTimeLabel(item.endedAt)}`
                )
                  .fontSize(AppTypography.helper)
                  .lineHeight(AppLineHeight.helper)
                  .fontColor(AppColors.mutedText)
                  .width('100%');

                if (item.note.trim() !== '') {
                  Text(item.note)
                    .fontSize(AppTypography.captionText)
                    .lineHeight(AppLineHeight.caption)
                    .fontColor(AppColors.secondaryText)
                    .width('100%')
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis });
                }
              }
              .width('100%')
              .padding(AppSpacing.section)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppRadius.buttonTonal);
            }, (item: FocusSession) => item.id);
          }
          .width('100%');
        }

        Column({ space: AppSpacing.section }) {
          Text(AppTexts.settingsTitle)
            .fontSize(AppTypography.cardTitle)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.primaryText);

          DurationSelector({
            selectedDuration: $selectedDuration
          });

          Button('保存默认时长')
            .type(ButtonType.Normal)
            .width('100%')
            .height(AppSizes.buttonHeightSmall)
            .borderRadius(AppRadius.buttonTonal)
            .backgroundColor(AppColors.action)
            .fontColor(AppColors.onActionText)
            .fontSize(AppTypography.buttonSmall)
            .stateStyles({
              pressed: {
                .opacity(0.88)
              },
              normal: {
                .opacity(1)
              }
            })
            .onClick(() => {
              void this.saveDefaultDuration();
            });

          Text(`${AppTexts.aboutApp} · 默认专注 ${this.selectedDuration} 分钟`)
            .fontSize(AppTypography.helper)
            .lineHeight(AppLineHeight.helper)
            .fontColor(AppColors.secondaryText);
        }
        .width('100%')
        .padding(AppSpacing.cardPadding)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppRadius.card);

        if (this.statusMessage !== '') {
          Text(this.statusMessage)
            .width('100%')
            .fontSize(AppTypography.helper)
            .lineHeight(AppLineHeight.helper)
            .textAlign(TextAlign.Center)
            .fontColor(AppColors.secondaryText);
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
