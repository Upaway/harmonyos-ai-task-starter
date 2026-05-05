import { FocusEndReason } from '../models/FocusSession';

export class AppTexts {
  static readonly appName: string = '开始做事';
  static readonly slogan: string = '先开始，再做完';
  static readonly homeTitle: string = '现在开始一件事';
  static readonly homeSubtitle: string = '今天不追求做很多，只先推进一次。';
  static readonly homeMoodLine: string = '今天适合从一件小事开始。';
  static readonly homeTaskHelper: string = '写下一句话，就可以开始第一段专注。';
  static readonly homeFooter: string = '今天不追求堆任务，只追求推进一次。';
  static readonly startConfirmTitle: string = '确认这次专注';
  static readonly focusTitle: string = '专注中';
  static readonly focusPausedLabel: string = '已暂停';
  static readonly statsTitle: string = '今天的推进';
  static readonly settingsTitle: string = '默认专注时长';
  static readonly taskValidationRequired: string = '先写下这次要开始的任务。';
  static readonly taskValidationTooLong: string = '任务文字过长，先压缩成一句具体动作。';
  static readonly noteValidationTooLong: string = '备注不要超过 100 个字。';
  static readonly placeholderTask: string = '例如：写需求文档、准备面试、整理房间';
  static readonly placeholderNote: string = '可选：记一句这次完成了什么，或卡在哪里。';
  static readonly resultSaveButton: string = '保存并返回首页';
  static readonly backToHomeButton: string = '返回首页';
  static readonly statsEmpty: string = '今天还没有专注记录。先开始一次 25 分钟，就有推进。';
  static readonly statsRecentEmpty: string = '还没有专注记录。完成一次专注后会出现在这里。';
  static readonly recentSessionsTitle: string = '最近记录';
  static readonly aboutApp: string = '开始做事 V0.1 · 本地优先';

  static getResultTitle(reason: FocusEndReason): string {
    if (reason === FocusEndReason.COMPLETED) {
      return '这一段做完了';
    }
    if (reason === FocusEndReason.EARLY_FINISH) {
      return '提前收束，也算完成';
    }
    return '这次先停在这里';
  }

  static getResultDescription(reason: FocusEndReason): string {
    if (reason === FocusEndReason.COMPLETED) {
      return '本次专注按计划结束，把结果记下来，下一次更容易接上。';
    }
    if (reason === FocusEndReason.EARLY_FINISH) {
      return '你提前结束了这次专注。只要任务推进了，这次就有价值。';
    }
    return '这次没有继续下去也没关系，记住卡点，下一次会更快进入状态。';
  }

  static getSessionStatusTag(reason: FocusEndReason): string {
    if (reason === FocusEndReason.COMPLETED) {
      return '按时完成';
    }
    if (reason === FocusEndReason.EARLY_FINISH) {
      return '提前完成';
    }
    return '放弃';
  }

  static getReasonLabel(reason: FocusEndReason): string {
    if (reason === FocusEndReason.COMPLETED) {
      return '正常结束';
    }
    if (reason === FocusEndReason.EARLY_FINISH) {
      return '提前完成';
    }
    return '放弃';
  }
}

