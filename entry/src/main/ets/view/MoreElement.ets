
import router from '@ohos.router'
import { WeatherModel } from '../viewModel/WeatherMode'
@Component
//右上角跳转
export struct MoreElement {
  @Link cityWeatherList: Array<WeatherModel>
  @Link cityCodeList:number[]
  @Link cityNameList:string[]
  build() {
    Row(){
      Column(){
         Row() {
           Button('管理城市')
             .width('90%')
             .fontColor(Color.Black)
             .fontWeight(310)
             .backgroundColor(Color.White)
             .onClick(()=>{
               router.replaceUrl(
                 {
                   url:'view/manageCityElement',
                   params:{
                     cityWeatherList:this.cityWeatherList,
                     cityCodeList:this.cityCodeList,
                     cityNameList:this.cityNameList
                   }
                 }
               )
             })
         }
        .height('49%')
        Divider()
        Row(){
          Button('设置')
            .width('90%')
            .fontColor(Color.Black)
            .fontWeight(310)
            .backgroundColor(Color.White)
        }
        .height('49%')
      }
      .justifyContent(FlexAlign.SpaceEvenly)
      .margin({right:6})
      .height('80%')
      .width('30%')
      .backgroundColor(Color.White)
      .borderRadius(15)
    }
    .alignItems(VerticalAlign.Top)
    .justifyContent(FlexAlign.End)
    .width('100%')
    .height('100%')
  }
}