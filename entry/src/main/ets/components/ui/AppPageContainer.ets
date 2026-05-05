import { AppColors, AppSizes } from '../../constants/AppTheme';

@Component
export struct AppPageContainer {
  @BuilderParam content: () => void;

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column()
        .width('100%')
        .height('100%')
        .linearGradient({
          angle: 165,
          colors: [[AppColors.backgroundStart, 0.0], [AppColors.backgroundEnd, 1.0]]
        });

      Column() {
        Column() {
          this.content();
        }
        .width('100%')
        .height('100%')
        .constraintSize({ maxWidth: AppSizes.contentMaxWidth });
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center);
    }
    .width('100%')
    .height('100%');
  }
}
