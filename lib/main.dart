import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/pages/saved_location_page.dart';
import 'package:weather/pages/splash_page.dart';
import 'package:weather/pages/weather_page.dart';
import 'package:weather/provider/weather_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WeatherProvider())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<WeatherProvider>().isDarkMode
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: context.watch<WeatherProvider>().myBlue,
              appBarTheme: AppBarTheme(
                color: context.watch<WeatherProvider>().myBlue,
              ))
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: context.watch<WeatherProvider>().myBlue,
              appBarTheme: AppBarTheme(
                color: context.watch<WeatherProvider>().myBlue,
              )),
      home: const SplashPage(),
    );
  }
}
