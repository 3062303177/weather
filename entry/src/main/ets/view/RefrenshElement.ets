
import PreferenceUtil from '../Util/PreferenceUtil'
import { forecasts } from '../viewModel/forecasts'
import { cityDaysElement } from './CityDaysElement'
import { Liftelement } from './LiftElement'
@Component
//主页面主体
export struct RefreshElement {
  @State isRefreshing: boolean = false
  @State forecasts:Array<forecasts>=[]
  build() {
    Column() {
      Refresh({ refreshing: $$this.isRefreshing }) {
        Scroll() {
          Column(){
            Row().height(100)
            Text(`更新于${this.forecasts[0].reporttime}`).fontSize(12).fontColor(Color.White).position({x:0,y:60})
            Text(this.forecasts[0].province).fontSize(18).fontWeight(350).fontColor(Color.White)
            Row().height(14)
            Text(this.forecasts[0].city).fontSize(25).fontWeight(400).fontColor(Color.White)
            Row(){
              Text(this.forecasts[0].casts[0].daytemp.toString()).fontSize(100).fontWeight(300).fontColor(Color.White)
                .margin({right:10})
              Column(){
                Text('℃').fontColor(Color.White)
              }
            }.margin({bottom:6})
            Row(){
              Text(this.forecasts[0].casts[0].dayweather).fontSize(25).fontWeight(400).fontColor(Color.White).margin({right:10})
              this.weatherImage(this.forecasts[0].casts[0].dayweather)
              Text(this.forecasts[0].casts[0].dayweather==='晴'?'请注意做好防晒':'').fontSize(10)
            }
            Row(){
              Column(){
                Text('白天').lineHeight(80)}.width('50%').height(120).border({color:{right:Color.White},width:{right:1}})
              Column(){
                Row(){
                  Text(`天气 : ${this.forecasts[0].casts[0].dayweather}`).margin({right:4})
                  this.weatherImage(this.forecasts[0].casts[0].dayweather)
                }
                Text(`温度 : ${this.forecasts[0].casts[0].daytemp}℃`)
                Text(`风向 : ${this.forecasts[0].casts[0].daywind}`)
                Text(`风速 : ${this.forecasts[0].casts[0].daypower}级`)
              }.width('50%').justifyContent(FlexAlign.SpaceAround).height('100%')
            }.height(120).margin({top:30}).border({color:Color.White,width:1})
            .borderRadius(10)
            Row(){
              Column(){
                Text('夜晚').lineHeight(80)}.width('50%').height(120).border({color:{right:Color.White},width:{right:1}})
              Column(){
                Row(){
                  Text(`天气 : ${this.forecasts[0].casts[0].nightweather}`).margin({right:4})
                  this.weatherImage(this.forecasts[0].casts[0].nightweather)
                }
                Text(`温度 : ${this.forecasts[0].casts[0].nighttemp}℃`)
                Text(`风向 : ${this.forecasts[0].casts[0].nightwind}`)
                Text(`风速 : ${this.forecasts[0].casts[0].nightpower}级`)
              }.width('50%').justifyContent(FlexAlign.SpaceAround).height('100%')
            }.height(120).margin({top:30}).border({color:Color.White,width:1})
            .borderRadius(10)

            //多日天气
            cityDaysElement({forecasts:$forecasts})

            //生活指数
            Liftelement({forecasts:$forecasts})
              .margin({bottom:20})

            //底部中国天气
            Row(){
               Image($r('app.media.wind')).height(30)
               Text('中国天气').fontColor('#8a8a8a').fontSize(14)
            }
            Row(){
              Text('天气版本 : 1.1.10.303').fontColor('#8a8a8a').fontSize(14)
            }

          }
          .width('100%')
        }
        .scrollBar(BarState.Off)
      }
      .onStateChange((refreshStatus: RefreshStatus) => {
        console.info('Refresh onStateChange state is ' + refreshStatus)
      })
      .onRefreshing(() => {
        setTimeout(() => {
          this.isRefreshing = false
        }, 2000)
      })
      .width('100%')
    }
    .width('100%')
  }
  @Builder weatherImage(weather:string){
    if(weather==='晴'){
      Image($r('app.media.fine')).height(20)
    }
    else if(weather==='阴'){
      Image($r('app.media.yin')).height(20)
    }
    else if(weather==='多云'){
      Image($r('app.media.manyCloud')).height(20)
    }
    else if(weather.includes('雨')){
      Image($r('app.media.smallrain')).height(20)
    }
  }
}function LiftElement(arg0: { forecasts: any }) {
throw new Error('Function not implemented.')
}
