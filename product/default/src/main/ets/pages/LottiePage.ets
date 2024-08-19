import lottie from '@ohos/lottie'
import { AnimationItem, AnimationEventCallback } from '@ohos/lottie'

@Entry
@Component
struct LottiePage {
  @State message: string = 'Hello Lottie';
  // 初始化渲染上下文
  private renderingSettings: RenderingContextSettings = new RenderingContextSettings(true) // 设置开启抗锯齿
  private renderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.renderingSettings)  // 创建2D渲染上下文
  private animateItem: AnimationItem | null = null;
  private animateName: string = "grunt";
  @State isCanvasVisible: Visibility = Visibility.Visible;

  aboutToAppear(): void {

  }

  build() {
    Column() {
      Text(this.message)
        .id('LottiePageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      // Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
        Canvas(this.renderingContext)
          .width('45%')
          .height(200)
          .backgroundColor(Color.Gray)
          .onReady(() => {
            // 可在此生命回调周期中加载动画，可以保证动画尺寸正确
            //抗锯齿的设置
            this.renderingContext.imageSmoothingEnabled = true;
            this.renderingContext.imageSmoothingQuality = 'medium'
            this.animateItem?.resize();
          })
          .onDisAppear(() => {
            lottie.destroy(this.animateName);
          })
          .visibility(this.isCanvasVisible)
      // }

      Button('加载grunt')
        .onClick(() => {
          if (this.animateItem == null) {
            this.animateItem = lottie.loadAnimation({
              container: this.renderingContext,
              renderer: 'canvas', // canvas 渲染模式
              loop: 10,
              autoplay: true,
              name: this.animateName,
              contentMode: 'Contain',
              path: "common/lottie/grunt.json", // 路径加载动画只支持entry/src/main/ets 文件夹下的相对路径
            })
          }

          this.animateItem.addEventListener('enterFrame', (args: Object): void => {
            console.info("lottie enterFrame");
          }); //只要播放，会一直触发
          this.animateItem.addEventListener('loopComplete', (args: Object): void => {
            console.info("lottie loopComplete");
          }); //动画播放一遍结束触发
          this.animateItem.addEventListener('complete', (args: Object): void => {
            console.info("lottie complete");
          }); //动画播放结束且不再播放动画触发
          this.animateItem.addEventListener('destroy', (args: Object): void => {
            console.info("lottie destroy");
          }); //删除动画触发
          this.animateItem.addEventListener('DOMLoaded', (args: Object): void => {
            console.info("lottie DOMLoaded");
          }); //动画加载完成，播放之前触发
        })
        .margin({ top: 5 })

      Button('播放')
        .onClick(() => {
          lottie.play();
        })
    }
    .height('100%')
    .width('100%')
  }
}