
@Component
//顶部导航栏
export struct TopElement {
  @Link isVisibility:boolean
  build() {
     Row(){
         Image($r('app.media.Four'))
           .margin({right:6,top:4})
           .height(30)
           .width(30)
           .backgroundColor(Color.Transparent)
           .onClick(()=>{
             this.isVisibility=!this.isVisibility
           })
     }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.End)
    .backgroundColor(Color.Transparent)
  }
}