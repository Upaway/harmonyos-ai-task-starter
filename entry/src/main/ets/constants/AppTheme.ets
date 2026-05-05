/**
 * Just Start — 全局视觉 Token
 * 温和、轻盈、有呼吸感；主色深墨蓝 + 暖金/奶油辅助。
 */

export class AppColors {
  /** 页面渐变起点（暖米白） */
  static readonly backgroundStart: string = '#FAF7F2';
  /** 页面渐变终点（浅杏灰） */
  static readonly backgroundEnd: string = '#EBE3D9';
  /** 兼容：纯背景 fallback */
  static readonly background: string = AppColors.backgroundStart;

  /** 标准卡片面（奶油白） */
  static readonly surface: string = '#FFFBF7';
  /** 上浮卡片（更亮） */
  static readonly surfaceElevated: string = '#FFFFFF';
  /** 暖色辅助面（浅杏） */
  static readonly surfaceWarm: string = '#F5EBE3';

  /** 主色深墨蓝（文字、沉浸面板、强对比场景） */
  static readonly primary: string = '#1C2830';
  /** 主色浅填充（弱背景、兼容） */
  static readonly primarySoft: string = '#E6ECF0';

  /** 交互行动色：主按钮、分段选中、轻量主操作（雾青蓝，比墨蓝更轻） */
  static readonly action: string = '#3F5E68';
  static readonly actionPressed: string = '#344F58';
  static readonly actionSoft: string = '#DDE9E8';
  static readonly onActionText: string = '#FFF8EF';

  static readonly primaryText: string = '#1C2830';
  static readonly secondaryText: string = '#5C656B';
  static readonly mutedText: string = '#8A9299';

  static readonly accent: string = '#C48B45';
  static readonly accentSoft: string = '#F0E4D4';

  /** 正向反馈（柔和苔绿） */
  static readonly success: string = '#5B7D6B';

  /** 危险操作（柔和陶红） */
  static readonly danger: string = '#A85C52';
  static readonly dangerSoft: string = '#F3DFDC';

  static readonly disabled: string = '#C8CED3';

  /** 主色上的文字 */
  static readonly onPrimaryText: string = '#FAF7F2';
  /** 深色面板上的弱化文字 */
  static readonly onPrimaryMuted: string = '#A8B0B6';

  /** 分割线 */
  static readonly divider: string = '#D9D0C6';
  static readonly dividerSoft: string = '#EBE4DA';

  /** 次级控件浅底 */
  static readonly controlSoft: string = '#E8E2DA';

  /** 输入框背景 */
  static readonly inputBackground: string = '#FFFFFF';

  /** 兼容旧名：segment 轨道等 */
  static readonly surfaceMuted: string = '#EDE6DE';
  /** 兼容旧名：与 surfaceWarm 同系 */
  static readonly surfaceSoft: string = AppColors.surfaceWarm;
}

/** 字体层级：主次分明，避免「全文粗黑」 */
export class AppTypography {
  static readonly heroTitle: number = 38;
  static readonly pageTitle: number = 28;
  static readonly pageSubtitle: number = 15;
  static readonly sectionTitle: number = 17;
  static readonly bodyText: number = 16;
  static readonly captionText: number = 13;
  /** 计时页绝对焦点 */
  static readonly timerNumber: number = 72;
  static readonly timerMeta: number = 14;
  static readonly buttonText: number = 17;
  static readonly buttonTextSmall: number = 15;
  static readonly tagText: number = 13;

  /** 兼容旧引用（逐步迁移） */
  static readonly homeTitle: number = AppTypography.heroTitle;
  static readonly subtitle: number = AppTypography.pageSubtitle;
  static readonly cardTitle: number = AppTypography.sectionTitle;
  static readonly body: number = AppTypography.bodyText;
  static readonly bodyLarge: number = 18;
  static readonly taskTitle: number = 22;
  static readonly helper: number = AppTypography.captionText;
  static readonly caption: number = 12;
  static readonly meta: number = 14;
  static readonly statNumber: number = 32;
  static readonly timerDisplay: number = 56;
  static readonly button: number = AppTypography.buttonText;
  static readonly buttonSmall: number = AppTypography.buttonTextSmall;
  static readonly tag: number = AppTypography.tagText;
}

export class AppLineHeight {
  static readonly heroTitle: number = 46;
  static readonly subtitle: number = 24;
  static readonly pageSubtitle: number = 24;
  static readonly body: number = 22;
  static readonly caption: number = 20;
  static readonly helper: number = 20;
  static readonly taskTitle: number = 32;
  static readonly taskQuoted: number = 30;
}

export class AppRadius {
  /** 页面主卡片 */
  static readonly cardMain: number = 26;
  /** 强调 / 沉浸面板 */
  static readonly cardFloat: number = 36;
  /** 输入框 */
  static readonly input: number = 20;
  static readonly inputSmall: number = 18;
  /** 胶囊主按钮 */
  static readonly pill: number = 999;
  /** 小标签、分段控件内 pill */
  static readonly chip: number = 14;
  static readonly tag: number = 18;
  /** 兼容 */
  static readonly cardHero: number = AppRadius.cardFloat;
  static readonly cardLarge: number = AppRadius.cardMain;
  static readonly card: number = 22;
  static readonly button: number = 26;
  static readonly buttonTonal: number = 22;
  static readonly buttonSmall: number = 18;
}

export class AppSpacing {
  static readonly pageHorizontal: number = 22;
  static readonly pageTop: number = 32;
  /** 常规页面下边距（满足至少约 48vp 安全区基准） */
  static readonly pageBottom: number = 48;
  /** 可滚动区域底部留白：手势条/导航条与内容间距（含按钮区场景建议 ≥64vp） */
  static readonly scrollContentBottom: number = 64;
  static readonly module: number = 22;
  static readonly section: number = 18;
  static readonly content: number = 14;
  static readonly item: number = 14;
  static readonly compact: number = 8;
  static readonly tiny: number = 6;
  static readonly cardPadding: number = 18;
  static readonly cardPaddingMedium: number = 20;
  static readonly cardPaddingLarge: number = 22;
  static readonly cardPaddingXLarge: number = 26;
  static readonly inputHorizontal: number = 16;
  static readonly tagHorizontal: number = 14;
  static readonly controlInset: number = 4;
}

export class AppSizes {
  /** 平板 / 折叠屏内屏等内容区最大宽度，避免横向过度拉伸 */
  static readonly contentMaxWidth: number = 520;
  static readonly buttonHeight: number = 54;
  static readonly buttonHeightMedium: number = 50;
  static readonly buttonHeightTonal: number = 48;
  static readonly buttonHeightSmall: number = 46;
  static readonly buttonHeightCompact: number = 44;
  static readonly tagHeight: number = 38;
  static readonly inputHeight: number = 54;
  static readonly segmentHeight: number = 42;
}

/** 轻阴影：层级感，避免厚重（具体 shadow API 在组件内展开） */
export class AppShadow {
  static readonly cardRadius: number = 22;
  static readonly cardOffsetY: number = 10;
  static readonly cardRadiusBlur: number = 22;
  static readonly cardColor: string = 'rgba(28, 40, 48, 0.10)';
  /** 主行动按钮（与 action 色相协调，避免纯黑影） */
  static readonly actionButton: string = 'rgba(63, 94, 104, 0.20)';
}

export class AppBorder {
  static readonly hairline: number = 0.5;
  static readonly thin: number = 1;
}

export class AppTextLimit {
  static readonly taskCompact: number = 2;
  static readonly taskRelaxed: number = 3;
}

export class AppLetterSpacing {
  static readonly label: number = 0.5;
  static readonly timer: number = 1.2;
}
