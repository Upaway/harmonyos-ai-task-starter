import { common } from '@kit.AbilityKit';
import { AppTexts } from '../constants/AppTexts';
import {
  AppBorder,
  AppColors,
  AppLineHeight,
  AppRadius,
  AppSizes,
  AppSpacing,
  AppTypography
} from '../constants/AppTheme';
import { DurationConstants, FocusDurationMinutes } from '../constants/DurationConstants';
import { RouteConstants } from '../constants/RouteConstants';
import { FocusEndReason } from '../models/FocusSession';
import { AppPageContainer } from '../components/ui/AppPageContainer';
import { DangerButton } from '../components/ui/DangerButton';
import { FocusTimerPanel } from '../components/ui/FocusTimerPanel';
import { PrimaryButton } from '../components/ui/PrimaryButton';
import { SecondaryButton } from '../components/ui/SecondaryButton';
import { setFocusKeepScreenOn } from '../utils/FocusWindowHelper';
import { FocusWallClockState, FocusViewModel } from '../viewmodels/FocusViewModel';

@Entry
@Component
struct FocusPage {
  @State private taskName: string = '';
  @State private durationMinutes: FocusDurationMinutes = DurationConstants.DEFAULT_DURATION;
  @State private remainingSeconds: number = DurationConstants.DEFAULT_DURATION * 60;
  @State private elapsedSeconds: number = 0;
  @State private isPaused: boolean = false;
  @State private hasValidParams: boolean = true;
  @State private pendingAction: string = 'none';

  private focusViewModel: FocusViewModel = new FocusViewModel();
  private wallClockState: FocusWallClockState | null = null;
  private timerHandle: number = -1;
  private startedAt: string = new Date().toISOString();
  private hasNavigated: boolean = false;
  private isFinishing: boolean = false;

  aboutToAppear(): void {
    try {
      const router = this.getUIContext().getRouter();
      const params = router.getState();
      const paramsObj: Record<string, string | number> = params?.params as Record<string, string | number> ?? {};
      const taskName: string = typeof paramsObj.taskName === 'string' ? paramsObj.taskName.trim() : '';
      const durationMinutes: FocusDurationMinutes = paramsObj.durationMinutes === 50 ? 50 : 25;

      if (taskName === '') {
        this.hasValidParams = false;
        return;
      }

      this.taskName = taskName;
      this.durationMinutes = durationMinutes;
      this.wallClockState = this.focusViewModel.createRuntimeState(durationMinutes);
      this.startedAt = new Date(this.wallClockState.wallStartedAtMs).toISOString();
      this.syncDerivedFromWallClock();
      this.hasValidParams = true;
      this.hasNavigated = false;
      this.isFinishing = false;

      const hostContext: common.Context = this.getUIContext().getHostContext() as common.Context;
      void setFocusKeepScreenOn(hostContext, true);
      this.startTimer();
    } catch (error) {
      console.error('FocusPage aboutToAppear error:', error);
      this.hasValidParams = false;
    }
  }

  aboutToDisappear(): void {
    const hostContext: common.Context = this.getUIContext().getHostContext() as common.Context;
    void setFocusKeepScreenOn(hostContext, false);
    this.clearTimer();
  }

  private syncDerivedFromWallClock(): void {
    if (this.wallClockState === null) {
      return;
    }
    const snapshot = this.focusViewModel.deriveSnapshot(this.wallClockState);
    this.remainingSeconds = snapshot.remainingSeconds;
    this.elapsedSeconds = snapshot.elapsedSeconds;
    this.isPaused = snapshot.isPaused;
  }

  private startTimer(): void {
    this.clearTimer();
    this.timerHandle = setInterval(() => {
      if (this.wallClockState === null) {
        return;
      }
      this.syncDerivedFromWallClock();

      if (this.remainingSeconds === 0) {
        void this.finishFocus(FocusEndReason.COMPLETED);
      }
    }, 1000) as number;
  }

  private clearTimer(): void {
    if (this.timerHandle >= 0) {
      clearInterval(this.timerHandle);
      this.timerHandle = -1;
    }
  }

  private togglePause(): void {
    if (this.wallClockState === null) {
      return;
    }
    this.wallClockState = this.focusViewModel.togglePause(this.wallClockState);
    this.syncDerivedFromWallClock();
  }

  private askAction(action: string): void {
    this.pendingAction = action;
  }

  private cancelAction(): void {
    this.pendingAction = 'none';
  }

  private async finishFocus(reason: FocusEndReason): Promise<void> {
    if (this.hasNavigated || this.isFinishing) {
      return;
    }

    this.isFinishing = true;
    this.syncDerivedFromWallClock();
    this.clearTimer();
    const hostContext: common.Context = this.getUIContext().getHostContext() as common.Context;
    const endedAt: string = new Date().toISOString();
    try {
      const router = this.getUIContext().getRouter();
      await router.pushUrl({
        url: RouteConstants.SESSION_RESULT_PAGE,
        params: {
          taskName: this.taskName,
          plannedDurationMinutes: this.durationMinutes,
          actualFocusSeconds: this.elapsedSeconds,
          endReason: reason,
          startedAt: this.startedAt,
          endedAt
        }
      });
      this.hasNavigated = true;
      this.isFinishing = false;
      void setFocusKeepScreenOn(hostContext, false);
    } catch (error) {
      console.error('FocusPage finishFocus error:', error);
      this.hasNavigated = false;
      this.isFinishing = false;
      if (this.remainingSeconds > 0) {
        void setFocusKeepScreenOn(hostContext, true);
        this.startTimer();
      } else {
        void setFocusKeepScreenOn(hostContext, false);
      }
    }
  }

  private getPendingTitle(): string {
    if (this.pendingAction === 'early') {
      return '确认这一段已经推进？';
    }
    if (this.pendingAction === 'abandon') {
      return '确认放弃这次？';
    }
    return '';
  }

  private getPendingDescription(): string {
    if (this.pendingAction === 'early') {
      return '做完就收束，这次专注会被记录下来。';
    }
    if (this.pendingAction === 'abandon') {
      return '放弃后也会进入结果页，你可以记下这次卡在哪里。';
    }
    return '';
  }

  private getPendingConfirmLabel(): string {
    if (this.pendingAction === 'early') {
      return '确认完成';
    }
    if (this.pendingAction === 'abandon') {
      return '确认放弃';
    }
    return '确认';
  }

  private getCompanionLine(): string {
    const hints: string[] = ['做得很好，继续保持。', '不用着急，只看眼前这一小步。', '先开始，就已经赢了一半。'];
    const idx = Math.floor(this.elapsedSeconds / 42) % hints.length;
    return hints[idx];
  }

  private confirmPendingAction(): void {
    if (this.pendingAction === 'early') {
      void this.finishFocus(FocusEndReason.EARLY_FINISH);
      return;
    }
    if (this.pendingAction === 'abandon') {
      void this.finishFocus(FocusEndReason.ABANDONED);
    }
  }

  build() {
    Column() {
      AppPageContainer() {
        Scroll() {
          Column({ space: AppSpacing.section }) {
            Column({ space: AppSpacing.tiny }) {
              Text(AppTexts.focusTitle)
                .fontSize(AppTypography.pageSubtitle)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.secondaryText)
                .width('100%');

              Text(this.hasValidParams ? '把注意力留在这一件事上。' : '参数缺失，无法启动这次专注。')
                .fontSize(AppTypography.captionText)
                .lineHeight(AppLineHeight.caption)
                .fontColor(AppColors.mutedText)
                .width('100%');
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start);

            if (this.hasValidParams) {
              FocusTimerPanel({
                taskName: this.taskName,
                durationMinutes: this.durationMinutes,
                remainingSeconds: this.remainingSeconds,
                isPaused: this.isPaused
              });

              if (this.pendingAction === 'none') {
                Text(this.getCompanionLine())
                  .fontSize(AppTypography.captionText)
                  .lineHeight(AppLineHeight.caption)
                  .fontColor(AppColors.secondaryText)
                  .width('100%')
                  .textAlign(TextAlign.Center)
                  .padding({ left: AppSpacing.section, right: AppSpacing.section });
              }

              PrimaryButton({
                label: this.isPaused ? '继续专注' : '暂停',
                isEnabled: true,
                onClickAction: () => {
                  this.togglePause();
                }
              });

              if (this.pendingAction === 'none') {
                Column({ space: AppSpacing.content }) {
                  Row({ space: AppSpacing.content }) {
                    Column() {
                      SecondaryButton({
                        label: '我做完了',
                        onClickAction: () => {
                          this.askAction('early');
                        }
                      });
                    }
                    .layoutWeight(1)
                    .width('100%');

                    Column() {
                      DangerButton({
                        label: '放弃这次',
                        onClickAction: () => {
                          this.askAction('abandon');
                        }
                      });
                    }
                    .layoutWeight(1)
                    .width('100%');
                  }
                  .width('100%');
                }
                .width('100%');
              } else {
                Column({ space: AppSpacing.content }) {
                  Text(this.getPendingTitle())
                    .fontSize(AppTypography.sectionTitle)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.primaryText)
                    .width('100%');

                  Text(this.getPendingDescription())
                    .fontSize(AppTypography.captionText)
                    .lineHeight(AppLineHeight.caption)
                    .fontColor(AppColors.secondaryText)
                    .width('100%');

                  Row({ space: AppSpacing.content }) {
                    Button('取消')
                      .type(ButtonType.Normal)
                      .layoutWeight(1)
                      .height(AppSizes.buttonHeightCompact)
                      .borderRadius(AppRadius.buttonSmall)
                      .backgroundColor(AppColors.controlSoft)
                      .fontColor(AppColors.primaryText)
                      .fontSize(AppTypography.tagText)
                      .stateStyles({
                        pressed: {
                          .opacity(0.88)
                        },
                        normal: {
                          .opacity(1)
                        }
                      })
                      .onClick(() => {
                        this.cancelAction();
                      });

                    Button(this.getPendingConfirmLabel())
                      .type(ButtonType.Normal)
                      .layoutWeight(1)
                      .height(AppSizes.buttonHeightCompact)
                      .borderRadius(AppRadius.buttonSmall)
                      .backgroundColor(this.pendingAction === 'abandon' ? AppColors.danger : AppColors.action)
                      .fontColor(AppColors.onActionText)
                      .fontSize(AppTypography.tagText)
                      .fontWeight(FontWeight.Medium)
                      .stateStyles({
                        pressed: {
                          .opacity(0.88)
                        },
                        normal: {
                          .opacity(1)
                        }
                      })
                      .onClick(() => {
                        this.confirmPendingAction();
                      });
                  }
                  .width('100%');
                }
                .width('100%')
                .padding(AppSpacing.cardPadding)
                .backgroundColor(AppColors.surfaceElevated)
                .borderRadius(AppRadius.cardMain)
                .border({ width: AppBorder.thin, color: AppColors.dividerSoft })
                .shadow({
                  radius: 16,
                  color: 'rgba(28, 40, 48, 0.08)',
                  offsetX: 0,
                  offsetY: 8
                });
              }
            } else {
              PrimaryButton({
                label: '返回首页',
                isEnabled: true,
                onClickAction: async () => {
                  try {
                    const router = this.getUIContext().getRouter();
                    await router.replaceUrl({
                      url: RouteConstants.HOME_PAGE
                    });
                  } catch (error) {
                    console.error('FocusPage replaceUrl error:', error);
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
