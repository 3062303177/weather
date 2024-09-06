import {casts} from '../../../../../../HarmonyOS_weather/entry/src/main/ets/viewModel/casts'

export class forecasts{
  city:string
  adcode:number
  province: string
  reporttime:string
  casts:Array<casts>
}