import {forecasts} from '../../../../../../HarmonyOS_weather/entry/src/main/ets/viewModel/forecasts'

export class WeatherModel{
  status:number
  count:number
  infocode:number
  forecasts:Array<forecasts>=[]
}