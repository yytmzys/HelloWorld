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
          Button('Hello World')
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
          Button('应用程序包')
            .onClick( () => {
              router.pushUrl({url: "pages/Module/ModulePage"})
            })
        }

        ListItem() {
          Button('天气')
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
          Button('组件状态管理')
            .onClick(() => {
              router.pushUrl({url: 'pages/stateManage/StateManagePage'})
            })
        }

        ListItem() {
          Button('渲染控制')
            .onClick(() => {
              router.pushUrl({url: 'pages/rendering/RenderingPage'})
            })
        }

        ListItem() {
          Button('网络请求')
            .onClick(() => {
              router.pushUrl({url: 'pages/netWork/NetWorkPage'})
            })
        }

        ListItem() {
          Button('lottie动画')
            .onClick(() => {
              router.pushUrl({url: 'pages/LottiePage'})
            })
        }

        ListItem() {
          Button('web和原生交互')
            .onClick(() => {
              router.pushUrl({url: 'pages/WebPage'})
            })
        }

        ListItem() {
          Button('数据持久化')
            .onClick(() => {
              router.pushUrl({url: 'pages/DataPersistencePage'})
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