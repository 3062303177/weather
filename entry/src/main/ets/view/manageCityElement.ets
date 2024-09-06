import router from '@ohos.router'
import { WeatherModel } from '../viewModel/WeatherMode'
import PreferenceUtil from '../Util/PreferenceUtil'

@Entry
@Component
//管理城市界面
struct manageCityElement {
  //接受数据的载体
  @State cityWeatherList: Array<WeatherModel> = []
  @State cityCodeList:number[]=[]
  @State cityNameList:string[]=[]

  //背景图片
  @State BackgroundImage:ResourceStr[]=[
  $r('app.media.backgroundImageFine'),
  $r('app.media.backgroundImageYin'),
  $r('app.media.backgroundImageManyCloud'),
  $r('app.media.backgroundImageRain'),
  ]

  onPageShow() {
    let params = router.getParams()
    this.cityWeatherList = params['cityWeatherList']
    this.cityCodeList=params['cityCodeList']
    this.cityNameList=params['cityNameList']
  }

  build() {
    Column() {
      Row() {
        Image($r('app.media.back')).height(30).margin({ right: 15 })
          .onClick(()=>{
            router.replaceUrl(
              {
                url:'pages/Index',
                params:{
                  cityCodeList:this.cityCodeList
                }
              }
            )
          })
        Text('管理城市').fontSize(25)
      }
      .justifyContent(FlexAlign.Start)
      .width('100%')
      .margin({ bottom: 25 })
      List(){
        ForEach(this.cityWeatherList,(Clist:WeatherModel,index:number)=>{
          ListItem(){
            Row() {
              Column(){
                Text(Clist.forecasts[0].city).fontSize(30).fontColor(Color.White)
                Text(Clist.forecasts[0].casts[0].dayweather).fontSize(25).fontColor(Color.White)
              }
              .width('50%')
              .height('100%')
              .borderColor(Color.Black)
              .justifyContent(FlexAlign.SpaceEvenly)
              Column() {
                Text(`${Clist.forecasts[0].casts[0].daytemp.toString()}/${Clist.forecasts[0].casts[0].nighttemp.toString()}℃`)
                  .fontColor(Color.White).fontSize(20)
              }
              .width('50%')
              .height('100%')
              .justifyContent(FlexAlign.Center)
            }

            .width('100%')
            .height('100%')
            .borderRadius(30)
            .backgroundImage(this.BackgroundImage[this.weatherImage(Clist.forecasts[0].casts[0].dayweather)])
            .backgroundImageSize(ImageSize.Cover)
          }
          .height(120)
          .borderRadius(30)
          .width('100%')
          .margin({bottom:15})
          .backgroundColor(Color.White)
          .swipeAction({end:this.DeleteButton(index)})
          .onClick(()=>{
            router.replaceUrl(
              {
                url:'pages/Index',
                params:{
                  cityCodeList:this.cityCodeList,
                  index:index
                }
              }
            )
          })
        })
      }
      .margin({bottom:150})
      Row(){
        Column(){
         Row() {
           Image($r('app.media.add')).fillColor(Color.Blue).height(10).size({ width: 20, height: 20 })
           Text('添加城市').fontColor(Color.Blue).fontSize(20).margin({ left: 5 })
         }
         .borderRadius(22)
          .padding({top:10,bottom:10,left:40,right:40})
          .backgroundColor('#ffefefef')
        }
      }.position({y:690}).width('100%').height(50).justifyContent(FlexAlign.Center)
      //点击跳转页面添加城市
      .onClick(()=>{
        router.replaceUrl(
          {
            url:'view/AddCityElement',
            params:{
              cityWeatherList:this.cityWeatherList,
              cityCodeList:this.cityCodeList,
              cityNameList:this.cityNameList
            }
          }
        )
      })
      }.width('100%')
      .height('100%')
      .margin({top:15})
      .padding({left:10,right:10})
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
  @Builder DeleteButton(index:number){
    Button(){
      Image($r('app.media.trash_can'))
        .height(30)
    }
    .backgroundColor(Color.Red)
    .height(50)
    .width(50)
    .margin({right:15,left:15})
    .onClick(async ()=>{
      this.cityCodeList.splice(index,1)
      await PreferenceUtil.Put('Mypreference','cityCodeList',this.cityCodeList)
      this.cityWeatherList.splice(index,1)
      this.cityNameList.splice(index,1)
    })
  }
}