import { preferences } from '@kit.ArkData'
import { Ability } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { window } from '@kit.ArkUI'

let dataPreferences: preferences.Preferences | null = null

@Entry
@Component
struct DataPersistencePage {
  @State message: string = 'Hello World';

  aboutToAppear(): void {
    let options: preferences.Options = {name: 'myStore'}
    // dataPreferences = preferences.getPreferences(this.getUIContext(), options)
  }
  build() {
    Column() {
      Text(this.message)
        .id('DataPersistencePageHelloWorld')
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