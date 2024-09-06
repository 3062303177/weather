
import { forecasts } from '../viewModel/forecasts'
@Component
export struct Liftelement {
  @Link forecasts:Array<forecasts>
  scroller: Scroller = new Scroller()
  build() {
    Column(){
      //头部
      Row(){
        Text('生活指数').fontSize(15)
      }.width('100%').justifyContent(FlexAlign.SpaceBetween).margin({bottom:8})
      Scroll(this.scroller){
        List(){
            ListItem(){
              Column(){
                Image($r('app.media.fish')).height(30)
                Text(this.forecasts[0].casts[0].dayweather==='晴'&&this.forecasts[0].casts[0].nightweather==='晴'?'适宜':'谨慎考虑')
                  .fontSize(15).fontColor(Color.White).margin({top:3,bottom:3})
                Text('钓鱼').fontSize(10).fontColor(Color.White)
              }.height(70).width(62).margin({right:10})
            }
            ListItem(){
              Column(){
                Image(Math.max(+this.forecasts[0].casts[0].daytemp,+this.forecasts[0].casts[0].nighttemp)>25?$r('app.media.duanxiu'):$r('app.media.dayi')).height(30)
                Text(Math.max(+this.forecasts[0].casts[0].daytemp,+this.forecasts[0].casts[0].nighttemp)>25?'短袖':'大衣').fontSize(15).fontColor(Color.White).margin({top:3,bottom:3})
                Text('穿衣').fontSize(10).fontColor(Color.White)
              }.height(70).width(62).margin({right:10})
            }
          ListItem(){
            Column(){
              Image($r('app.media.fangshai')).height(30)
              Text(this.forecasts[0].casts[0].dayweather==='晴'&&this.forecasts[0].casts[0].nightweather==='晴'&&Math.max(+this.forecasts[0].casts[0].daytemp,+this.forecasts[0].casts[0].nighttemp)>25?'需要':'适宜').fontSize(15).fontColor(Color.White).margin({top:3,bottom:3})
              Text('防晒').fontSize(10).fontColor(Color.White)
            }.height(70).width(62).margin({right:10})
          }
          ListItem(){
            Column(){
              Image($r('app.media.yao')).height(30)
              Text(Math.max(+this.forecasts[0].casts[0].daytemp,+this.forecasts[0].casts[0].nighttemp)>25?'不易':'注意保暖').fontSize(15).fontColor(Color.White).margin({top:3,bottom:3})
              Text('感冒').fontSize(10).fontColor(Color.White)
            }.height(70).width(62).margin({right:10})
          }
          ListItem(){
            Column(){
              Image($r('app.media.liangshai')).height(30)
              Text(this.forecasts[0].casts[0].dayweather==='晴'&&this.forecasts[0].casts[0].nightweather==='晴'?'适宜':'不宜').fontSize(15).fontColor(Color.White).margin({top:3,bottom:3})
              Text('晾晒').fontSize(10).fontColor(Color.White)
            }.height(70).width(62)
          }
        }
        .listDirection(Axis.Horizontal)
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)

    }
    .margin({top:20}).padding({top:10,left:10,right:10,bottom:6}).borderColor(Color.White).borderWidth(1).borderRadius(10)
    .margin({top:20}).padding({top:10,left:10,right:10,bottom:6}).borderColor(Color.White).borderWidth(1).borderRadius(10)
  }
}