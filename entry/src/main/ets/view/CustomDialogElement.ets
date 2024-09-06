//自定义弹窗
@CustomDialog
export struct customDialogExample {
  controller:CustomDialogController
  confirm:()=>void
  cancel:()=>void
  build(){
    Column(){
      Row(){
        Text('请确认是否添加当前城市天气数据')
          .fontSize(20)
          .lineHeight(25)
          .textAlign(TextAlign.Center)
      }.height(85)
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .padding(20)
      Row(){
        Text('注意保护隐私哦，谨慎思考！！').fontSize(15)
      }
      .height(20)
      .margin({bottom:10})
      .alignItems(VerticalAlign.Center)
      Row(){
        //确认按钮
        Button(){
          Text('确认').fontSize(25).fontColor('#ff6bb156')
        }
        .ButtonStyle()
        .onClick(async ()=>{
          this.confirm()
          this.controller.close()
        })

        Text('|').fontSize(28).fontColor(Color.Gray)

        Button(){
          Text('取消').fontSize(21)
        }
          .ButtonStyle()
        .onClick(()=>{
            this.cancel()
            this.controller.close()
        })

      }
      .width('100%')
    }.height(150)
  }

  @Styles ButtonStyle(){
      .height(40)
      .width('49%')
    .backgroundColor(Color.White)
   }

}


