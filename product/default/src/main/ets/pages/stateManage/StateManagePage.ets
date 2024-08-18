import router from '@ohos.router';

@Entry
@Component
struct StateManagePage {
  @State message: string = 'Hello StateManage';

  build() {
    RelativeContainer() {
      List() {
        ListItem() {
          Text('Observed+ObjectLink-嵌套类对象属性变化')
            .fontWeight(FontWeight.Bold)
            .onClick(() => {
                                 //"pages/stateManage/ObservedObjectLinkPage"
              router.pushUrl({url: "pages/stateManage/ObservedObjectLinkPage"})
            })
        }


      }
    }
    .height('100%')
    .width('100%')
    .margin({left: 15, right: 15})
  }
}