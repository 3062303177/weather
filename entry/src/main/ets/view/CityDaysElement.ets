
import PreferenceUtil from '../Util/PreferenceUtil'
import { casts } from '../viewModel/casts'
import { forecasts } from '../viewModel/forecasts'

@Component
export struct cityDaysElement{
  @Link forecasts:Array<forecasts>
  @State Istransform:boolean=false

  // private settings: RenderingContextSettings = new RenderingContextSettings(true)
  // private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  //
  // @State MaxTemp:number[]=[]
  // @State MinTemp:number[]=[]

  build() {
      Column(){
        //头部
        Row(){
          Text('多日预报').fontSize(15)
          Image($r('app.media.transform')).height(20)
            .onClick(async ()=>{
              this.Istransform=!this.Istransform
            })
        }.width('100%').justifyContent(FlexAlign.SpaceBetween)
        if(this.Istransform){
          Column(){
            ForEach(this.forecasts[0].casts,(cast:casts)=>{
              Row(){
                Text(cast.date.substring(5)).width('20%')
                if(cast.dayweather===cast.nightweather){
                  Row(){this.weatherImage(cast.dayweather)}.width('20%').padding({left:10})
                }
                else {
                  Row(){
                    Row(){this.weatherImage(cast.dayweather)}.margin({right:4})
                    this.weatherImage(cast.nightweather)
                  }.width('20%')
                }
                if(cast.dayweather===cast.nightweather){
                  Text(cast.dayweather).width('35%')
                }
                else {
                  Row(){
                    Text(cast.dayweather+'转'+cast.nightweather)
                  }.width('35%')
                }
                Row(){Text(cast.daytemp.toString()+' / '+cast.nighttemp.toString()+'℃')}.width('25%').justifyContent(FlexAlign.End)
              }
              .margin({bottom:15})
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            })
          }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({top:15})
        }
        else{
          // Canvas(this.context)
          //   .width('100%')
          //   .height('100%')
          //   .backgroundColor('#ffff00')
          //   .onReady(() => {
          //     this.context.fillRect(0, 30, 100, 100)
          //   })

          // Row(){
          //   ForEach(this.forecasts[0].casts,(cast:casts)=>{
          //     Column(){
          //       Text(cast.date.substring(5)).margin({bottom:5}).fontSize(12)
          //       this.weatherImage(cast.dayweather)
          //       Text(cast.dayweather).margin({top:5,bottom:5})
          //       Text(cast.daytemp.toString()+'℃').margin({bottom:5})
          //     }
          //   })
          // }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({top:15})
          // Row(){
          // ForEach(this.forecasts[0].casts,(cast:casts)=>{
          //   Column(){
          //     Text(cast.nighttemp.toString()+'℃').margin({bottom:5})
          //     this.weatherImage(cast.nightweather)
          //     Text(cast.nightweather).margin({top:5,bottom:20})
          //   }
          // })
          // }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({top:15})

          Row(){
            ForEach(this.forecasts[0].casts,(cast:casts)=>{
              Column(){
                Text(cast.date.substring(5)).margin({bottom:5})
                this.weatherImage(cast.dayweather)
                Text(cast.dayweather).margin({top:5,bottom:5})
                Text(cast.daytemp.toString()+'℃').margin({bottom:5})
                Line().width(20).height(80).startPoint([10,0]).endPoint([10,70]).stroke(Color.Black)
                  .strokeWidth(3).strokeDashArray([10,3])
                Text(cast.nighttemp.toString()+'℃').margin({bottom:5})
                this.weatherImage(cast.nightweather)
                Text(cast.nightweather).margin({top:5,bottom:20})
              }
            })
          }.justifyContent(FlexAlign.SpaceBetween).width('100%').margin({top:15})
        }
      }
    .margin({top:20}).padding({top:10,left:10,right:10}).borderColor(Color.White).borderWidth(1).borderRadius(10)
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
}


