import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weathe_checker/domain/models/future_weather_api_model.dart';
import 'package:weathe_checker/domain/models/weather_api_model.dart';

class WeatherService {
  final baseUrl = "https://api.openweathermap.org/data/2.5/weather?";

  Future<WeatherApiModel> getServices(String lat, String lon) async {
    const apikey = "919985b44e7885f7050eb04965eb1991";
    const unit = 'metric';

    try {
      final url = await  http.get(Uri.parse("${baseUrl}lat=$lat&lon=$lon&appid=$apikey&units=$unit"));
      

      if (url.statusCode == 200) {
        final jsonResponse = await jsonDecode(url.body);
        return WeatherApiModel.fromJson(jsonResponse as Map<String, dynamic>);
      } else {
        throw Exception("Failed to load weather data (Status code: ${url.statusCode})");
      }
    } 
    catch (e) {
      throw Exception("Error: $e");
    }
  }
}

class FutureWeatherService {
  final baseUrl = "https://api.openweathermap.org/data/2.5/forecast?";

  Future<FutureWeatherApiModel> futureGetServices(String lat, String lon) async {
    const apikey = "919985b44e7885f7050eb04965eb1991";
    const unit = 'metric';

    

    try {
      final url = await  http.get(Uri.parse("${baseUrl}lat=$lat&lon=$lon&appid=$apikey&units=$unit"));
      final jsonResponse = await jsonDecode(url.body);
         
      if (url.statusCode == 200) {
        
        return FutureWeatherApiModel.fromJson(jsonResponse as Map<String, dynamic>);
      } else {
        throw Exception("Failed to load weather data (Status code: ${url.statusCode})");
      }

      
    } 
    catch (e) {
      throw Exception("Error: $e");
    }
    
  }
  
}
