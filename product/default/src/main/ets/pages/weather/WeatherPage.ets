@Entry
@Component
struct WeatherPage {
  @State message: string = 'Hello Weather';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('WeatherPageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}