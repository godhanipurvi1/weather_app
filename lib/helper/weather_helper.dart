import "dart:convert";
import "package:http/http.dart" as http;
import "../model/weather_model.dart";

class WeatherHelper {
  Future<WeatherModel?> weatherHelper(String city) async {
    String weatherApiLink =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=c1dea0524d4525d490e1c8c03c92e2b6";
    http.Response response = await http.get(
      Uri.parse(weatherApiLink),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      WeatherModel weather = WeatherModel.maptomodel(json);
      return weather;
    }
    return null;
  }
}
