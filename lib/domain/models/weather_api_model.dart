// To parse this JSON data, do
//
//     final weatherApiModel = weatherApiModelFromJson(jsonString);

import 'dart:convert';

WeatherApiModel weatherApiModelFromJson(String str) => WeatherApiModel.fromJson(json.decode(str));

String weatherApiModelToJson(WeatherApiModel data) => json.encode(data.toJson());

class WeatherApiModel {
    Coord? coord;
    List<Weather>? weather;
    String? base;
    Main? main;
    Wind? wind;
 
    int? dt;
    Sys? sys;
    int? timezone;
    int? id;
    String? name;
    int? cod;

    WeatherApiModel({
         this.coord,
         this.weather,
         this.base,
         this.main,
         this.wind,
        
         this.dt,
         this.sys,
         this.timezone,
         this.id,
         this.name,
         this.cod,
    });

    factory WeatherApiModel.fromJson(Map<String, dynamic> json) => WeatherApiModel(
        coord: Coord.fromJson(json["coord"]),
        weather: List<Weather>.from(json["weather"].map((e) => Weather.fromJson(e))),
        base: json["base"],
        main: Main.fromJson(json["main"]),
        wind: Wind.fromJson(json["wind"]),
        
        dt: json["dt"],
        sys: Sys.fromJson(json["sys"]),
        timezone: json["timezone"],
        id: json["id"],
        name: json["name"],
        cod: json["cod"],
    );

    Map<String, dynamic> toJson() => {
        "coord": coord!.toJson(),
        "weather": List<dynamic>.from(weather!.map((e) => e.toJson())),
        "base": base,
        "main": main!.toJson(),
        "wind": wind!.toJson(),
        
        "dt": dt,
        "sys": sys!.toJson(),
        "timezone": timezone,
        "id": id,
        "name": name,
        "cod": cod,
    };
}


class Coord {
    double lon;
    double lat;

    Coord({
        required this.lon,
        required this.lat,
    });

    factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lon": lon,
        "lat": lat,
    };
}

class Main {
    double temp;
    int humidity;

    Main({
        required this.temp,
        required this.humidity,
    });

    factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"]?.toDouble(),
        humidity: json["humidity"],
    );

    Map<String, dynamic> toJson() => {
        "temp": temp,
        "humidity": humidity,
    };
}

class Sys {
    String country;
    int sunrise;
    int sunset;

    Sys({
        required this.country,
        required this.sunrise,
        required this.sunset,
    });

    factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
    );

    Map<String, dynamic> toJson() => {
        "country": country,
        "sunrise": sunrise,
        "sunset": sunset,
    };
}

class Weather {
    int id;
    String main;
    String description;
    String icon;

    Weather({
        required this.id,
        required this.main,
        required this.description,
        required this.icon,
    });

    factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
    };
}

class Wind {
    double speed;

    Wind({
        required this.speed,
    });

    factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "speed": speed,
    };
}
