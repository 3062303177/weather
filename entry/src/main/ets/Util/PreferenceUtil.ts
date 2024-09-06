import preferences from '@ohos.data.preferences';
class PreferenceUtil{

   PreMap:Map<String,preferences.Preferences> =new Map()

  //加载用户首选项
   loadPreference(context,name:string){
    preferences.getPreferences(context,name)
      .then(pref=>{
        this.PreMap.set(name,pref)
      })
      .catch(reason=>{
        console.log('testTag',`加载Preferences[${name}]失败`,JSON.stringify(reason));
      })
  }

  //增加用户首选项
    async Put(name:string,key:string,value:preferences.ValueType){
    if(!this.PreMap.has(name)){
      console.log('testLog',`pregerence${name}尚未初始化`);
      return
    }
    let pref = this.PreMap.get(name)
    await pref.put(key,value)
    await pref.flush()
    console.log('testLog',`pregerence${name}保存成功`);
  }

  //得到用户首选项
   async get(name:string,key:string,defaultValue:preferences.ValueType){
    if(!this.PreMap.has(name)){
      console.log('testLog',`pregerence${name}尚未初始化`);
      return
    }
    let pref = this.PreMap.get(name)
    let value= pref.get(key,defaultValue)
    return value
    console.log('testLog',`pregerence${name}获取成功`);
  }
}
const preferenceUtil=new PreferenceUtil()
export default preferenceUtil as PreferenceUtil