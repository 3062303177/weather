
import http from '@ohos.net.http'
import { LocationClass } from './LocationClass'

class GetLocation{
  getLocation(){
    return new Promise<LocationClass>((resolve,reject)=>{//Promise接收回调函数
      //创建http的请求对象，不可复用
      let request =http.createHttp()

      let url=`https://restapi.amap.com/v3/ip?output=json&key=c7e41058c52ef967a6cb2c5d6f72c285`

      //发送请求对象
      let result=request.request(url)

      result.then((res)=>{
        if(res.responseCode===200){
          resolve(JSON.parse(res.result.toString()))
        }
      })
        .catch((err)=>{
          console.log(err)
          reject('查询失败')
        })
    })
  }
}

const getLocation =new GetLocation()
export default getLocation as GetLocation