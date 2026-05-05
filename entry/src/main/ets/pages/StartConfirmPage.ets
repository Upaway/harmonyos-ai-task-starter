import { AppTexts } from '../constants/AppTexts';
import { AppSpacing } from '../constants/AppTheme';
import { DurationConstants, FocusDurationMinutes } from '../constants/DurationConstants';
import { RouteConstants } from '../constants/RouteConstants';
import { AppPageContainer } from '../components/ui/AppPageContainer';
import { ConfirmFocusCard } from '../components/ui/ConfirmFocusCard';
import { GhostButton } from '../components/ui/GhostButton';
import { PageHeader } from '../components/ui/PageHeader';
import { PrimaryButton } from '../components/ui/PrimaryButton';

@Entry
@Component
struct StartConfirmPage {
  @State private taskName: string = '';
  @State private durationMinutes: FocusDurationMinutes = DurationConstants.DEFAULT_DURATION;
  @State private hasValidParams: boolean = true;

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
      this.hasValidParams = true;
    } catch (error) {
      console.error('StartConfirmPage aboutToAppear error:', error);
      this.hasValidParams = false;
    }
  }

  private getConfirmSubtitle(): string {
    return `接下来 ${this.durationMinutes} 分钟，只专注这一件事。`;
  }

  private getInvalidSubtitle(): string {
    return '缺少任务信息，请返回首页重新开始。';
  }

  private getTaskBody(): string {
    return `「${this.taskName}」`;
  }

  private async startFocus(): Promise<void> {
    try {
      const router = this.getUIContext().getRouter();
      await router.pushUrl({
        url: RouteConstants.FOCUS_PAGE,
        params: {
          taskName: this.taskName,
          durationMinutes: this.durationMinutes
        }
      });
    } catch (error) {
      console.error('StartConfirmPage startFocus error:', error);
    }
  }

  build() {
    Column() {
      AppPageContainer() {
      Scroll() {
        Column({ space: AppSpacing.section }) {
          PageHeader({
            title: AppTexts.startConfirmTitle,
            subtitle: this.hasValidParams ? this.getConfirmSubtitle() : this.getInvalidSubtitle()
          });

          ConfirmFocusCard({
            taskQuoted: this.getTaskBody(),
            durationMinutes: this.durationMinutes,
            hasValidParams: this.hasValidParams,
            hintText: this.hasValidParams ? '不求做完，只先推进一小步。' : ''
          });

          if (this.hasValidParams) {
            Column({ space: AppSpacing.item }) {
              PrimaryButton({
                label: '正式开始',
                isEnabled: true,
                onClickAction: () => {
                  void this.startFocus();
                }
              });

              GhostButton({
                label: '返回修改',
                onClickAction: () => {
                  try {
                    const router = this.getUIContext().getRouter();
                    router.back();
                  } catch (error) {
                    console.error('StartConfirmPage back error:', error);
                  }
                }
              });
            }
            .width('100%');
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
                  console.error('StartConfirmPage replaceUrl error:', error);
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
