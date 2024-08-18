import { router } from '@kit.ArkUI';
import { ComplexNumber } from '@ohos/common'
import { Add } from '@ohos/common'
@Entry
@Component
struct Index {
  complexNum: string = new ComplexNumber(2, 3).toString()

  build() {
    Column() {
      List( {space: 20}) {
        ListItem() {
          Text('Hello World')
            .fontWeight(FontWeight.Bold)
            .alignRules({
              center: { anchor: '__container__', align: VerticalAlign.Center },
              middle: { anchor: '__container__', align: HorizontalAlign.Center }
            })
            .onClick(() => {
              router.pushUrl({url:"pages/HelloWorld/HelloWorldPage"})
            })
        }

        ListItem() {
          Text('应用程序包')
            .onClick( () => {
              router.pushUrl({url: "pages/Module/ModulePage"})
            })
        }

        ListItem() {
          Text('天气')
            .onClick(() => {
              router.pushUrl({url: "pages/weather/WeatherPage"})
            })
        }

        ListItem() {
          Text('复数: ' + this.complexNum)
        }

        ListItem() {
          Text('3 + 5 = ' + Add(3, 5).toString())
        }

        ListItem() {
          Text('组件状态管理')
            .onClick(() => {
              router.pushUrl({url: 'pages/stateManage/StateManagePage'})
            })
        }

        ListItem() {
          Text('渲染控制')
            .onClick(() => {
              router.pushUrl({url: 'pages/rendering/RenderingPage'})
            })
        }

        ListItem() {
          Text('网络请求')
            .onClick(() => {
              router.pushUrl({url: 'pages/netWork/NetWorkPage'})
            })
        }
      }
      .width('100%')
      .height('100%')


    }
    .height('100%')
    .width('100%')
    .margin({left: 15, right: 15})
  }
}