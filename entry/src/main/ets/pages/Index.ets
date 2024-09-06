
import router from '@ohos.router'
import { MoreElement } from '../view/MoreElement'
import { RefreshElement } from '../view/RefrenshElement'
import { TopElement } from '../view/TopElement'
import GetWeatherUtil from '../viewModel/GaoDEgetWeatherUtil'
import { WeatherModel } from '../viewModel/WeatherMode'
import PreferenceUtil from '../Util/PreferenceUtil';
@Entry
@Component
struct Index {
  @State isVisibility:boolean=true
  @Provide cityCodeList: number[] = [110101,130724,140827]
  @State cityWeatherList: Array<WeatherModel> = []
  @State cityNameList:string[]=[]
  @State Index:number=0
  //背景图片
  @State BackgroundImage:ResourceStr[]=[
  $r('app.media.fine2'),
  $r('app.media.backgroundImageYin'),
  $r('app.media.backgroundImageManyCloud'),
  $r('app.media.rain2'),
  ]

  onPageShow() {
    let params = router.getParams()
    if(params){
      this.cityCodeList = params['cityCodeList']
      this.Index=params['index']
      this.cityWeatherList=[]
      this.initDate()
    }else {
      this.initDate()
    }
  }

  //初始化方法
  async initDate() {
    this.cityCodeList=await PreferenceUtil.get('Mypreference','cityCodeList',[110101,110102]) as number[]
    let result: Array<WeatherModel> =await GetWeatherUtil.getWeathers(this.cityCodeList)
    for (let i = 0; i < result.length; i++) {
      this.cityWeatherList.push(result[i])
      this.cityNameList.push(result[i].forecasts[0].city)
    }
  }

   Scontroller: SwiperController = new SwiperController()

  build() {
    Column() {
      Stack(){

        Swiper(this.Scontroller){
          ForEach(this.cityWeatherList,(cityWeather:WeatherModel)=>{
            // Stack(){
            //   Image(this.BackgroundImage[this.weatherImage(cityWeather.forecasts[0].casts[0].dayweather)])
            //   Column(){
            //     RefreshElement({forecasts:cityWeather.forecasts})
            //       .height('100%')
            //       .width('100%')
            //   }
            //   .padding({left:15,right:15,bottom:30})
            //   .backgroundImageSize(ImageSize.Cover)
            // }

            Column(){
              RefreshElement({forecasts:cityWeather.forecasts})
                .height('100%')
                .width('100%')
            }
            .padding({left:15,right:15,bottom:30})
            .backgroundImage(this.BackgroundImage[this.weatherImage(cityWeather.forecasts[0].casts[0].dayweather)])
            .backgroundImageSize(ImageSize.Cover)
          })
        }
        .index(this.Index)
        .loop(false)
        //头部
        Row(){TopElement({isVisibility:$isVisibility})}
        .backgroundColor(Color.Transparent)
        .TopRow()

        //点击更多出现组件
        Row(){MoreElement({cityCodeList:$cityCodeList, cityWeatherList: $cityWeatherList ,cityNameList:$cityNameList})}
        .MoreRow()

      }
      .alignContent(Alignment.Top)
      .height('100%')
      .width('100%')
    }
    .width('100%').height('100%')
    .onClick(()=>{this.isVisibility=true})
  }
  weatherImage(weather:string):number{
    if (weather === '晴') {
      return 0
    }
    else if (weather === '阴') {
      return 1
    }
    else if (weather === '多云') {
      return 2
    }
    else if (weather.includes('雨')) {
      return 3
    }
  }
}

@Styles function TopRow(){
  .width('100%')
  .height(60)
}

@Styles function MoreRow() {
  .visibility(this.isVisibility?Visibility.Hidden:Visibility.Visible)
  .width('100%')
  .height(120)
  .position({y:60})
}
