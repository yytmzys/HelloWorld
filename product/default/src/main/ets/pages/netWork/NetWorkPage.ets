import http from '@ohos.net.http';
import { BusinessError } from '@kit.BasicServicesKit'
import axios, {
  AxiosError,
  AxiosResponse,
  AxiosProgressEvent,
  InternalAxiosRequestConfig,
  AxiosRequestConfig
} from '@ohos/axios'

let httpRequest = http.createHttp();

interface userInfo{
  id: number
  name: string,
  phone: number
}

@Entry
@Component
struct NetWorkPage {
  @State message: string = '点击原生请求'
  @State message2: string = 'axios点击请求'

  build() {
    Column() {
      Text(this.message)
        .margin({top: 50})
        .onClick(() => {
          // 1
          httpRequest.request('https://v.api.aa1.cn/api/api-zi/index.php?msg=爱', (err: BusinessError, data) => {
            if (!err) {
              console.info('结果1:' + data.result);
              this.message = JSON.stringify(data.result)
              console.info('code:' + data.responseCode);
              console.info('header:' + JSON.stringify(data.header));
              console.info('cookies:' + data.cookies); // 8+
            } else {
              console.info('error:' + JSON.stringify(err));
            }
          })
        })

      Text(this.message2)
        .margin({top: 50})
        .onClick(() => {
          // 2 发送一个get请求
          axios<string, AxiosResponse<string>, null>({
            method: "get",
            url: 'https://v.api.aa1.cn/api/api-zi/index.php',
            params: {
              msg: '爱',
              otherParam: 'test'
            }
          }).then((res: AxiosResponse) => {
            console.info('结果2:' + JSON.stringify(res.data));
            this.message2 = JSON.stringify(res.data)
            console.log(`axios结果${this.message}`)
          }).catch((error: AxiosError) => {
            console.error('axios失败' + error.message)
          })

          // 添加请求拦截器
          axios.interceptors.request.use((config:InternalAxiosRequestConfig) => {
            // 对请求数据做点什么
            if (config.params && typeof config.params === 'object') {
              let paramsString = JSON.stringify(config.params);
              console.log('参数替换前: ' + paramsString);
              // 替换参数
              paramsString = paramsString.replace(/爱/g, "哈");
              console.log('参数替换后: ' + paramsString);
              // 将字符串重新解析为对象
              config.params = JSON.parse(paramsString);
            } else {
              console.log('参数为空或不是对象，未进行替换');
            }
            return config;
          }, (error:AxiosError) => {
            // 对请求错误做些什么
            return Promise.reject(error);
          });


          // 添加响应拦截器
          axios.interceptors.response.use((response:AxiosResponse)=> {
            // 对响应数据做点什么
            return response;
          }, (error:AxiosError)=> {
            // 对响应错误做点什么
            return Promise.reject(error);
          });

        })
    }
    .height('100%')
    .width('100%')
  }
}