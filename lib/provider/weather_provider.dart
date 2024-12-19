import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/helper/weather_helper.dart';

import '../model/weather_model.dart';

class WeatherProvider with ChangeNotifier {
  bool isDarkMode = true;
  int selectedIndex = 0;
  WeatherModel? weather;
  Color myBlue = const Color.fromRGBO(6, 8, 32, 1);
  Color myWhite = const Color.fromRGBO(120, 120, 120, 0.4);
  DateTime? localTime;
  DateTime? utcTime;
  String? formattedDate;
  String? iconFullPath;
  String? imageFullPath;
  double? celsius;
  List<WeatherModel> cities = [];
  TextEditingController? textEditingController = TextEditingController();

  var iconPath = 'lib/assets/icons/3d/3d/';
  var imagePath = 'lib/assets/weatherImage/';

  SharedPreferences? prefs;
  WeatherProvider() {
    loadPreferences();
  }
  void loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
    loadSavedCities();
    notifyListeners();
  }

  Future<void> saveWeatherData(String key, String value) async {
    if (prefs != null) {
      prefs!.setString(key, value);
    }
  }

  String? loadWeatherData(String key) {
    return prefs?.getString(key);
  }

  Future<void> saveCities() async {
    if (prefs != null && cities.isNotEmpty) {
      List<String> cityNames = cities.map((city) => city.name!).toList();
      List<double> cityTemperatures = cities.map((city) => celsius!).toList();
      List<String> cityIcons = cities.map((city) => iconFullPath!).toList();

      await prefs!.setStringList('savedCities', cityNames);
      await prefs!.setStringList('savedCityIcons', cityIcons);
      await prefs!.setStringList('savedCityTemperatures',
          cityTemperatures.map((e) => e.toString()).toList());
    }
  }

  void loadSavedCities() {
    List<String>? cityNames = prefs?.getStringList('savedCities');
    List<String>? cityIcons = prefs?.getStringList('savedCityIcons');
    List<String>? cityTemperatures =
        prefs?.getStringList('savedCityTemperatures');

    // if (cityNames != null) {
    //   cities = cityNames
    //       .asMap()
    //       .map((index, name) {
    //         double temp = double.tryParse(cityTemperatures?[index] ?? '0') ?? 0;
    //         String icon = cityIcons?[index] ?? '';
    //         return MapEntry(index,
    //             WeatherModel(name: name, celsius: temp, iconFullPath: icon));
    //       })
    //       .values
    //       .toList();
    // }
  }

  // List icons = [
  //   Icons.home,
  //   Icons.search_rounded,
  //   Icons.map,
  //   Icons.settings,
  // ];
  // List pages = [
  //   const WeatherPage(),
  //   const SearchPage(),
  //   const SavedLocationPage(),
  //   const SettingPage(),
  // ];

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    //notifyListeners();
  }

  void onItemTap(int index, BuildContext context) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> getWeather(
      // String city
      ) async {
    WeatherHelper helper = WeatherHelper();
    weather = await helper.weatherHelper("new york");
    calculateLocalTime(weather!.dt!.toInt(), weather!.timezone!.toInt());
    formatDate(
      localTime!,
    );
    // context.read<WeatherProvider>().toggleTheme();
    kelvinToCelsius(weather!.mainModel!.temp!.toDouble());
    getIcon(weather!.weatherM![0].icon.toString());
    getImage(weather!.weatherM![0].icon.toString());

    notifyListeners();
  }

  void calculateLocalTime(int dt, int timezone) {
    utcTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000, isUtc: true);

    localTime = utcTime?.add(Duration(seconds: timezone));
    notifyListeners();
  }

  void formatDate(localTime) {
    DateFormat dateFormat = DateFormat("d MMM yyyy "
        //    ,"h:mm a"
        );
    formattedDate = dateFormat.format(localTime);
    notifyListeners();
  }

  void kelvinToCelsius(double temp) {
    celsius = temp - 273.15;
    notifyListeners();
  }

  void addToSavedList(WeatherModel weatherCity) {
    cities.add(weatherCity);
    notifyListeners();
  }

  void removeFromCites(int index) {
    // cities.removeWhere((bookmark) => bookmark.cityName == city);

    cities.remove(index);
    notifyListeners();
  }

  void getIcon(String icon) {
    switch (icon) {
      case "01d":
        iconFullPath = '${iconPath}sun/26.png';
        break;
      case "01n":
        iconFullPath = '${iconPath}moon/41.png';
        break;
      case "02d":
        iconFullPath = '${iconPath}cloud/35.png';
        break;
      case "02n":
        iconFullPath = '${iconPath}moon/31.png';
        break;
      case "03d":
        iconFullPath = '${iconPath}sun/4.png';
        break;
      case "03n":
        iconFullPath = '${iconPath}moon/41.png';
        break;
      case "04d":
        iconFullPath = '${iconPath}sun/4.png';
        break;
      case "04n":
        iconFullPath = '${iconPath}moon/41.png';
        break;
      case "09d":
        iconFullPath = '${iconPath}cloud/5.png';
        break;
      case "09n":
        iconFullPath = '${iconPath}cloud/5.png';
        break;
      case "10d":
        iconFullPath = '${iconPath}cloud/07.png';
        break;
      case "10n":
        iconFullPath = '${iconPath}moon/1.png';
        break;
      case "11d":
        iconFullPath = '${iconPath}cloud/17.png';
        break;
      case "11n":
        iconFullPath = '${iconPath}moon/11.png';
        break;
      case "13d":
        iconFullPath = '${iconPath}cloud/18.png';
        break;
      case "13n":
        iconFullPath = '${iconPath}moon/19.png';
        break;
      case "50d":
        iconFullPath = '${iconPath}sun/28.png';
        break;
      case "50n":
        iconFullPath = '${iconPath}sun/28.png';
        break;
      default:
        iconFullPath = '${iconPath}sun/27.png';
    }
  }

  void getImage(String icon) {
    switch (icon) {
      case "01d":
        imageFullPath = '${imagePath}clear.jpg';
        break;
      case "01n":
        imageFullPath = '${imagePath}clearSkyNight.jpg';
        break;
      case "02d":
        imageFullPath = '${imagePath}clear.jpg';
        break;
      case "02n":
        imageFullPath = '${imagePath}fewCloudsNight.jpg';
        break;
      case "03d":
        imageFullPath = '${imagePath}scatteredCloudDay.jpg';
        break;
      case "03n":
        imageFullPath = '${imagePath}scatteredCloudNight.jpg';
        break;
      case "04d":
        imageFullPath = '${imagePath}clear.jpg';
        break;
      case "04n":
        imageFullPath = '${imagePath}brokenCloudsNight.jpg';
        break;
      case "09d":
        imageFullPath = '${imagePath}rainDay.jpg';
        break;
      case "09n":
        imageFullPath = '${imagePath}rainNight.jpg';
        break;
      case "10d":
        imageFullPath = '${imagePath}rainDay.jpg';
        break;
      case "10n":
        imageFullPath = '${imagePath}rainNight.jpg';
        break;
      case "11d":
        imageFullPath = '${imagePath}ThunderstromskyDay.jpg';
        break;
      case "11n":
        imageFullPath = '${imagePath}ThunderstromNight.jpg';
        break;
      case "13d":
        imageFullPath = '${imagePath}snowDay.jpg';
        break;
      case "13n":
        imageFullPath = '${imagePath}snowNight.jpg';
        break;
      case "50d":
        imageFullPath = '${imagePath}mistDay.jpg';
        break;
      case "50n":
        imageFullPath = '${imagePath}mistNight.jpg';
        break;
      default:
        imageFullPath = '${imagePath}clear.jpg';
    }
  }
}
