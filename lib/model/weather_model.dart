// class WeatherModel {
//   String? cod;
//   int? message, cnt;
//   List<WeatherEntry>? list;
//   final CityModel? cityModel;
//   WeatherModel({this.list, this.cityModel, this.cnt, this.cod, this.message});
//   factory WeatherModel.maptomodel(Map m) {
//     return WeatherModel(
//         cod: m["cod"],
//         message: m["message"],
//         cnt: m["cnt"],
//         list: List<WeatherEntry>.from(
//             m["list"].map((e) => WeatherEntry.maptomodel(e))),
//         // (m["list"] as List).map((e) => WeatherEntry.maptomodel(e)).toList(),
//         cityModel: CityModel.maptomodel(m["city"]));
//   }
// }
//
// class WeatherEntry {
//   int? dt, visibility, pop;
//   MainModel? mainModel;
//   List<Weather>? weather = [];
//   CloudsModel? cloudsModel;
//   WindModel? windModel;
//   SysModel? sysModel;
//   String? dt_txt;
//   WeatherEntry(
//       {this.cloudsModel,
//       this.dt,
//       this.dt_txt,
//       this.mainModel,
//       this.pop,
//       this.sysModel,
//       this.visibility,
//       this.weather,
//       this.windModel});
//   factory WeatherEntry.maptomodel(Map m) {
//     print(m);
//     return WeatherEntry(
//       dt: m["dt"],
//       visibility: m["visibility"],
//       pop: m["pop"],
//       mainModel: MainModel.maptomodel(m["main"]),
//       weather:
//           (m["weather"] as List).map((e) => Weather.maptomodel(e)).toList(),
//       cloudsModel: CloudsModel.maptomodel(m["clouds"]),
//       windModel: WindModel.maptomodel(m["wind"]),
//       sysModel: SysModel.maptomodel(m["sys"]),
//       dt_txt: m["dt_txt"],
//     );
//   }
// }
//
// class MainModel {
//   double? temp, feels_like, temp_min, temp_max, temp_kf;
//   int? pressure, sea_level, grnd_level, humidity;
//   MainModel(
//       {this.feels_like,
//       this.grnd_level,
//       this.humidity,
//       this.pressure,
//       this.sea_level,
//       this.temp,
//       this.temp_kf,
//       this.temp_max,
//       this.temp_min});
//   factory MainModel.maptomodel(Map m) {
//     return MainModel(
//       temp: m["temp"],
//       feels_like: m["feels_like"],
//       grnd_level: m["grnd_level"],
//       humidity: m["humidity"],
//       pressure: m["pressure"],
//       sea_level: m["sea_level"],
//       temp_kf: m["temp_kf"],
//       temp_max: m["temp_max"],
//       temp_min: m["temp_min"],
//     );
//   }
// }
//
// class Weather {
//   int? id;
//   String? main, description, icon;
//   Weather({this.id, this.main, this.description, this.icon});
//   factory Weather.maptomodel(Map m) {
//     return Weather(
//       id: m["id"],
//       description: m["description"],
//       icon: m["icon"],
//       main: m["main"],
//     );
//   }
// }
//
// class CloudsModel {
//   int? all;
//   CloudsModel({this.all});
//   factory CloudsModel.maptomodel(Map m) {
//     return CloudsModel(all: m["all"]);
//   }
// }
//
// class WindModel {
//   double? speed, gust;
//   int? deg;
//   WindModel({this.deg, this.gust, this.speed});
//   factory WindModel.maptomodel(Map m) {
//     return WindModel(deg: m["deg"], gust: m["gust"], speed: m["speed"]);
//   }
// }
//
// class SysModel {
//   String? pod;
//   SysModel({this.pod});
//   factory SysModel.maptomodel(Map m) {
//     return SysModel(pod: m["pod"]);
//   }
// }
//
// class CityModel {
//   int? id, population, timezone, sunrise, sunset;
//   String? name, country;
//   CoordModel? coordModel;
//   CityModel(
//       {this.name,
//       this.id,
//       this.coordModel,
//       this.country,
//       this.population,
//       this.sunrise,
//       this.sunset,
//       this.timezone});
//   factory CityModel.maptomodel(Map m) {
//     return CityModel(
//         id: m["id"],
//         population: m["population"],
//         timezone: m["timezone"],
//         sunrise: m["sunrise"],
//         sunset: m["sunset"],
//         name: m["name"],
//         country: m["country"],
//         coordModel: CoordModel.maptomodel(
//           m["coord"],
//         ));
//   }
// }
//
// class CoordModel {
//   int? lat, lon;
//   CoordModel({this.lat, this.lon});
//   factory CoordModel.maptomodel(Map m) {
//     return CoordModel(lat: m["lat"], lon: m["lon"]);
//   }
// }

class WeatherModel {
  String? base, name;
  int? visibility, dt, timezone, id, cod;
  CoordModel? coordModel;
  List<WeatherM>? weatherM;
  MainModel? mainModel;
  WindModel? windModel;
  CloudsModel? cloudModel;
  SysModel? sysModel;
  WeatherModel({
    this.coordModel,
    this.mainModel,
    this.cod,
    this.weatherM,
    this.sysModel,
    this.timezone,
    this.id,
    this.name,
    this.visibility,
    this.dt,
    this.base,
    this.cloudModel,
    this.windModel,
  });
  factory WeatherModel.maptomodel(Map m) {
    return WeatherModel(
        base: m["base"],
        name: m["name"],
        visibility: m["visibility"],
        dt: m["dt"],
        timezone: m["timezone"],
        id: m["id"],
        cod: m["cod"],
        coordModel: CoordModel.maptomodel(m["coord"]),
        weatherM: m["weather"] != null
            ? List<WeatherM>.from(
                m["weather"].map((e) => WeatherM.maptomodel(e)),
              )
            : null,
        mainModel: MainModel.maptomodel(m["main"]),
        windModel: WindModel.maptomodel(m["wind"]),
        cloudModel: CloudsModel.maptomodel(m["clouds"]),
        sysModel: SysModel.maptomodel(m["sys"]));
  }
}

class CoordModel {
  double? lon, lat;
  CoordModel({this.lon, this.lat});
  factory CoordModel.maptomodel(Map m) {
    return CoordModel(
      lon: m["lon"],
      lat: m["lan"],
    );
  }
}

class WeatherM {
  int? id;
  String? main, description, icon;
  WeatherM({this.id, this.icon, this.description, this.main});
  factory WeatherM.maptomodel(Map m) {
    return WeatherM(
      id: m["id"],
      main: m["main"],
      description: m["description"],
      icon: m["icon"],
    );
  }
}

class MainModel {
  double? temp, feels_like, temp_min, temp_max;
  int? pressure, humidity, sea_level, grnd_level;
  MainModel(
      {this.temp_min,
      this.temp_max,
      this.temp,
      this.sea_level,
      this.pressure,
      this.humidity,
      this.grnd_level,
      this.feels_like});
  factory MainModel.maptomodel(Map m) {
    return MainModel(
      temp: m["temp"],
      feels_like: m["feels_like"],
      temp_min: m["temp_min"],
      temp_max: m["temp_max"],
      pressure: m["pressure"],
      humidity: m["humidity"],
      sea_level: m["sea_level"],
      grnd_level: m["grnd_level"],
    );
  }
}

class WindModel {
  double? speed, gust;
  int? deg;
  WindModel({this.speed, this.gust, this.deg});
  factory WindModel.maptomodel(Map m) {
    return WindModel(
      speed: m["speed"],
      gust: m["gust"],
      deg: m["deg"],
    );
  }
}

class CloudsModel {
  int? all;
  CloudsModel({this.all});
  factory CloudsModel.maptomodel(Map m) {
    return CloudsModel(all: m["all"]);
  }
}

class SysModel {
  String? country;
  int? sunrise, sunset;
  SysModel({this.sunset, this.sunrise, this.country});
  factory SysModel.maptomodel(Map m) {
    return SysModel(
      country: m["country"],
      sunrise: m["sunrise"],
      sunset: m["sunset"],
    );
  }
}
