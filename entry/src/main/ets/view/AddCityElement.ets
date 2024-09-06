import router from '@ohos.router'
import { WeatherModel } from '../viewModel/WeatherMode'
import { customDialogExample } from './CustomDialogElement'
import Storage from '../viewModel/CityNameAndCode'
import { LocationClass } from '../viewModel/LocationClass'
import GetLocation from '../viewModel/GetLocation'
import PreferenceUtil from '../Util/PreferenceUtil'
import prompt from '@ohos.prompt'

type Result={code:number;name:string}

@Entry
@Component
struct addCityElement {
  private locationmessage:LocationClass

  //搜索框输入数据
  @State messageValue:string=''
  //记录搜索历史内容
  @State HotCity:string[]=['北京','上海','重庆','广州','成都','杭州','三亚','西安','昆明','长沙','青岛','南京','海口','武汉']
  @State HotCityName:Result[]=[{code:110000,name:'beijingshi'},{code:310000,name:'shanghaishi'},{code:500000,name:'chongqingshi'},{code:440100	,name:'guangzhoushi'},
    {code:510100,name:'chengdushi'}, {code:330100,name:'hangzhoushi'},{code:460200,name:'sanyashi'},{code:610100,name:'xianshi'},{code:530100,name:'kunmingshi'},
    {code:430100,name:'changshashi'},{code:370200,name:'qingdaoshi'},{code:320100,name:'nanjingshi'},{code:460100,name:'haikoushi'},
    {code:420100,name:'wuhanshi'}]

  //接受数据的载体
  @State cityWeatherList: Array<WeatherModel> = []
  @State cityCodeList:number[]=[]
  @State cityNameList:string[]=[]
  @State Index:number=0

  //接受搜素到的数据
  @State result:Result[]=[]
  @State partResult:Result[]=[]


  //声明弹窗控制器
  dialogController:CustomDialogController=new CustomDialogController({
    builder:customDialogExample({
      confirm:() => this.onConfirm(),
      cancel:() => this.onCancel()
    })
  })

  //确定后的执行
  async onConfirm(){
    this.locationmessage=await GetLocation.getLocation()
    if(this.cityNameList.includes(this.locationmessage.city)){
      let isAgree: Boolean = false;
      try {
        const result = await prompt.showDialog({
          title: '城市信息',
          message: `"${this.locationmessage.city}"已存在，请勿重复添加`,
          buttons: [
            {
              text: '确认',
              color: '#ffb02424'
            }
          ],
        });
      } catch (err) {
        console.info('showDialog error: ' + err);
      }
    }
    else{
      this.cityCodeList.unshift(this.locationmessage.adcode)
      this.cityNameList.unshift(this.locationmessage.city)
      try {
        await PreferenceUtil.Put('Mypreference','cityCodeList',this.cityCodeList)
      }catch (err){
        console.log(err)
      }
      router.replaceUrl({
        url:'pages/Index',
        params:{
          cityCodeList:this.cityCodeList,
          cityNameList:this.cityNameList
        }
      })
      this.dialogController.close()
    }
  }

  //取消后
  onCancel(){
    this.dialogController.close()
  }

  onPageShow() {
    let params = router.getParams()
    this.cityWeatherList = params['cityWeatherList']
    this.cityCodeList=params['cityCodeList']
    this.cityNameList=params['cityNameList']
  }

  build() {
    Column(){
      Row() {
        Row(){
          Image($r('app.media.back')).height(30).margin({ right: 15 })
            .onClick(()=>{
              router.replaceUrl({
                url:'view/manageCityElement',
                params:{
                  cityWeatherList:this.cityWeatherList,
                  cityCodeList:this.cityCodeList,
                  cityNameList:this.cityNameList
                }
              })
            })
          Text('添加城市').fontSize(25)
        }
        .justifyContent(FlexAlign.Start)
        Image($r('app.media.absolute')).height(25)
          .onClick(()=>{
               this.dialogController.open()
          })
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({ bottom: 25 })
      Row(){
        TextInput({placeholder:'搜索城市（拼音）'}).width('90%')
          .onChange(value=>{
            this.result=[]
            this.messageValue=value
            if(this.messageValue===''){
              return
            }else{
              if(/^\d{1,6}$/.test(this.messageValue)){
                this.result=Storage.findSpot(Storage.Code,Number(this.messageValue))
                this.partResult=this.result.splice(0,20)
              }else{
                this.result=Storage.findElementById(Storage.Pinyin_name,this.messageValue)
                this.partResult=this.result.splice(0,20)
              }
            }
          })
        Image($r('app.media.search')).height(50)
      }
       .margin({bottom:10})
      //渲染结果
        if(this.messageValue===''){
          Text('请输入搜索信息').margin({top:20,bottom:20})

          //热门城市模块
          Row(){
            Row(){
              Text('热门城市').fontSize(18).fontColor(Color.Gray)
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .height(30)
            .width('100%')
            .position({x:0,y:0})
            Row(){
              Grid(){
                ForEach(this.HotCity,(item:string,index:number)=>{
                  GridItem(){
                    Button(item)
                      .height(30)
                      .width(60)
                      .margin({top:2,bottom:3})
                      .backgroundColor('#ffc1c1c1')
                      .onClick(async ()=>{
                       if(!this.cityCodeList.includes(this.HotCityName[index].code)){
                         this.cityCodeList.unshift(this.HotCityName[index].code)
                         this.cityNameList.unshift(this.HotCityName[index].name)
                         await PreferenceUtil.Put('Mypreference','cityCodeList',this.cityCodeList)
                       }
                        router.replaceUrl({
                          url:'pages/Index',
                          params:{
                            cityCodeList:this.cityCodeList
                          }
                        })
                      })
                  }
                })
              }
              .height(145)
              .columnsTemplate('1fr 1fr 1fr 1fr')
            }
            .margin({top:40})
          }
          // .height(100)
          .width('95%')
          .backgroundColor('#fff5f5f5')
          .padding({top:2,bottom:2,left:12,right:12})
          .borderRadius(25)
          .alignItems(VerticalAlign.Center)


        }else{
          List(){
            ForEach(this.partResult,(item:Result,index:number)=>{
              ListItem(){
                Row(){
                  Row(){
                    Text(item.name.length<=7?item.name:item.name.slice(0,7)+'...').fontSize(25).margin({right:30})
                    Text(item.code.toString())
                  }.onClick(()=>{
                    if(this.cityNameList.includes(item.name)){
                      this.Index=this.cityCodeList.indexOf(item.code)
                      router.replaceUrl({
                        url:'pages/Index',
                        params:{
                          cityCodeList:this.cityCodeList,
                          index:this.Index
                        }
                      })
                    }
                  })
                   if(this.cityNameList.includes(item.name)){
                     Image($r('app.media.right')).height(30)
                   }else{
                     Image($r('app.media.add')).height(30)
                       .onClick(async ()=>{
                         this.cityCodeList.unshift(item.code)
                         this.cityNameList.unshift(item.name)
                         await PreferenceUtil.Put('Mypreference','cityCodeList',this.cityCodeList)
                         router.replaceUrl({
                           url:'pages/Index',
                           params:{
                             cityCodeList:this.cityCodeList
                           }
                         })
                       })
                   }
                }
                .justifyContent(FlexAlign.SpaceBetween)
                .padding({left:20,right:10})
                .height(60)
                .margin({bottom:5})
                .width('100%')
                .backgroundColor(this.cityNameList.includes(item.name) ? '#fffadede' : '#ffbcf3e3')
                .borderRadius(10)
              }
              .onAppear(()=>{
                 if(index=this.partResult.length){
                  this.partResult=this.partResult.concat(this.result.slice(this.partResult.length,this.partResult.length+20))
                 }
              })
            })
          }.layoutWeight(1)
          .margin({bottom:15})
        }
    }
    .width('100%')
    .height('100%')
    .margin({top:15})
    .padding({left:10,right:10})
  }
}