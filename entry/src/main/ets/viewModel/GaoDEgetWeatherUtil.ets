
import http from '@ohos.net.http'
import { WeatherModel } from './WeatherMode'
class getWeatherUtil{
  getWeather(cityCode:number){
    return new Promise<WeatherModel>((resolve,reject)=>{//Promise接收回调函数
      //创建http的请求对象，不可复用
      let request =http.createHttp()

      let url=`https://restapi.amap.com/v3/weather/weatherInfo?city=${cityCode}&key=c7e41058c52ef967a6cb2c5d6f72c285&extensions=all`

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
  async getWeathers(cityCodes:Array<number>){
    let promises:Array<Promise<WeatherModel>>=[]
    let weatherModels:Array<WeatherModel>=[]
    for (let index = 0; index < cityCodes.length; index++) {
     promises.push(this.getWeather(cityCodes[index]))
    }
    await Promise.all(promises).then(result=>{
      weatherModels=result
    })
    return weatherModels
  }

}
const GetWeatherUtil=new getWeatherUtil()
export default GetWeatherUtil