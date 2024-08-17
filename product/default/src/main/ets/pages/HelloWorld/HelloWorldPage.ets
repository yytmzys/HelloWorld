import { router } from '@kit.ArkUI';

@Entry
@Component
struct HelloWorldPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Text(this.message)
        .id('Hello World')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Button() {
        Text('Next')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .width('40%')
      .height('5%')
      .backgroundColor('#0D9FFB')
      .type(ButtonType.Capsule)
      .onClick((event: ClickEvent) => {
        router.pushUrl( {url: "pages/HelloWorld/SecondPage"})
      })
    }
    .height('100%')
    .width('100%')
  }
}