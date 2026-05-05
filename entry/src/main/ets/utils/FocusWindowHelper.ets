import { common } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

/**
 * 专注页保持屏幕常亮（代替锁屏的第一版策略）。
 */
export async function setFocusKeepScreenOn(context: common.Context | undefined, keepOn: boolean): Promise<void> {
  if (context === undefined) {
    return;
  }
  try {
    const win = await window.getLastWindow(context);
    await win.setWindowKeepScreenOn(keepOn);
  } catch (error) {
    console.error('setFocusKeepScreenOn error:', error);
  }
}
