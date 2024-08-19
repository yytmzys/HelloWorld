import { webview } from '@kit.ArkWeb';
import { BusinessError } from '@kit.BasicServicesKit';

class student {
  name: string = '';
  age: string = '';
}

class ObjOther {
  methodNameListForJsProxy: string[]

  constructor(list: string[]) {
    this.methodNameListForJsProxy = list
  }

  testOther(json: string): void {
    console.info(json)
  }
}

class testClass {
  ObjReturn: ObjOther

  constructor() {
    this.ObjReturn = new ObjOther(["testOther"]);
  }

  testESObject(): ESObject {
    return this.ObjReturn
  }

  test(): string {
    return 'ArkUI Web Component';
  }

  testArray(): Array<Number> {
    return [1, 2, 3, 4]
  }

  testHello(param: ESObject): void {
    param.hello("call obj func");
  }

  testPromise1(): Promise<string> {
    let p: Promise<string> = new Promise((resolve, reject) => {  setTimeout(() => {console.log('执行完成'); reject('fail');}, 10000);});
    return p;
  }

  testPromise2(param:Function): void {
    setTimeout( () => { param("suc") }, 10000)
  }

  toString(param: String): void {
    console.log('Web Component toString: ' + param);
  }

  // 传递的基础类型name:"jeck", age:"12"。
  testStudent(): student {
    let st: student = { name: "jeck", age: "12" };
    return st;
  }

  toString2(param: ESObject): void {
    console.log('Web Component toString: ' + param["name"]);
  }

  testCallback(param: Function): void {
    param("call callback");
  }
}

@Entry
@Component
struct WebPage {
  @State message: string = 'Hello Web';
  webviewController: webview.WebviewController = new webview.WebviewController();
  @State testObj: testClass = new testClass();
  scroller: Scroller = new Scroller()

  aboutToAppear() {
    // 配置Web开启调试模式
    webview.WebviewController.setWebDebuggingAccess(true);
  }

  build() {
    Scroll(this.scroller) {
      Column() {
        Text(this.message)
          .id('Web')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })

        Text('1.1 web加载url')
        Web({ src: 'www.baidu.com', controller: this.webviewController })
          .width('100%')
          .height('10%')

        Text('1.2 web加载本地html')
          .margin({ top: 10 })
        Web({ src: $rawfile('index.html'), controller: this.webviewController })
          .width('100%')
          .height('20%')// 将对象注入到web端
          .javaScriptProxy({
            object: this.testObj,
            name: "testObjName",
            methodList: ["test"],
            controller: this.webviewController
          })

        Button('2.1 原生调用web方法runJavaScript')
          .onClick(() => {
            this.webviewController.runJavaScript('htmlTest()')
          })

        Button('2.2 原生调用runJavaScript传递参数给web')
          .margin({ top: 10 })
          .onClick(() => {
            // 传递runJavaScript侧代码方法。
            this.webviewController.runJavaScript(`function changeColor(){document.getElementById('text').style.color = 'red'}`);
          })


        Button('3.1 原生方法注册到web-registerJavaScriptProxy')
          .margin({ top: 10 })
          .onClick(() => {
            try {
              this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ['test', "toString"]);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })

        Button('3~7.2 Web.refresh, 刷新才生效')
          .margin({ top: 10 })
          .backgroundColor(Color.Red)
          .onClick(() => {
            try {
              this.webviewController.refresh();
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })

        Button('4.1 原生和web传递Array')
          .margin({ top: 10 })
          .onClick(() => {
            try {
              this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["testArray", 'toString']);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })

        Button('5.1 传递数据类型')
          .margin({ top: 10 })
          .onClick(() => {
            try {
              this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["testStudent", 'toString2']);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })

        Button('6.1 原生调Web页CallBack')
          .margin({ top: 10 })
          .onClick(() => {
            try {
              this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["testCallback", "toString"]);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })

        Button('7.1 应用调前端Object里Function')
          .margin({ top: 10 })
          .onClick(() => {
            try {
              this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["testHello", "toString"]);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })

        Button('8.1 web页调应用侧Object的Function')
          .margin({ top: 10 })
          .onClick(() => {
            try {
              this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["testESObject", "toString"]);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })

        Button('9.1 Promise1, 在应用侧new Promise。')
          .margin({ top: 10 })
          .onClick(() => {
            try {
              this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["testPromise1", "toString"]);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })

        Button('10.1 Promise2, 在前端页面new Promise。')
          .margin({ top: 10 })
          .onClick(() => {
            try {
              this.webviewController.registerJavaScriptProxy(this.testObj, "testObjName", ["testPromise2", "toString"]);
            } catch (error) {
              console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
            }
          })
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .scrollable(ScrollDirection.Vertical) // 滚动方向为水平方向
  }
}