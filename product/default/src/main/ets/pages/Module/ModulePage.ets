import { router } from '@kit.ArkUI';

@Entry
@Component
struct ModulePage {
  @State message: string = 'ModulePage';

  build() {
    Column() {
      Text(this.message)
        .id('ModulePage')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Button('Back')
        .onClick((event: ClickEvent) => {
          router.back()
        })
        .width('40%')
        .height('5%')
        .backgroundColor('#0D9FFB')
    }
    .height('100%')
    .width('100%')
  }
}