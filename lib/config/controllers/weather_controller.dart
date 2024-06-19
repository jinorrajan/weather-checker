
import 'package:get/get.dart';
import 'package:weathe_checker/data/localdata/locationSharedpreference.dart';
import 'package:weathe_checker/data/dataService/weather_data_service.dart';
import 'package:weathe_checker/domain/models/future_weather_api_model.dart';
import 'package:weathe_checker/domain/models/weather_api_model.dart';

import '../../domain/models/location_model.dart';

class WeatherController extends GetxController {
  RxBool loading = true.obs;
  var locationModel = LocationModel().obs;
  var datamodel = WeatherApiModel().obs;
  var futureDataModel = FutureWeatherApiModel().obs;


Future<void> loadLocationAndGetData() async{
  final locationss = await LocationSharedPreference.loadLocationData();
  if(locationss != null){
    await getData(locationss.latitude ?? "",locationss.longitude ?? "");
    await futureDataGet(locationss.latitude ?? "",locationss.longitude ?? "");
    
  }
}

//current DataGet
Future<void> getData(String lat, String lon) async{
  try{
    loading.value = true;
    final WeatherApiModel weatherData = await WeatherService().getServices(lat, lon);
    datamodel.value = weatherData;
  } on Exception catch (error){
    print("Error fetching weather data: $error");
  }finally{
    loading.value = false;
  }
}

//Future data Get
Future<void> futureDataGet(String lat, String lon) async{
  try{
    loading.value = true;
    final FutureWeatherApiModel futureWeatherData = await FutureWeatherService().futureGetServices(lat, lon);
    futureDataModel.value = futureWeatherData;
  } on Exception catch (error){
    print("Error fetching weather data: $error");
  }finally{
    loading.value = false;
  }
}

void setlocation(String lat,String lon ){
  locationModel.value = LocationModel(latitude: lat,longitude: lon);
  getData(lat, lon);
  futureDataGet(lat, lon);
}
  @override
  void onInit() {
    loadLocationAndGetData();
  
    super.onInit();
  }

}

