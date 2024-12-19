import 'package:flutter/material.dart';
import 'package:weather/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      //   Navigator.pushReplacementNamed(context, "home_page");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        const SizedBox(
          height: 200,
        ),
        Image.asset(
          'lib/assets/icons/3d/3d/sun/27.png',
          height: 250,
        ),
        const SizedBox(
          height: 40,
        ),
        const Text(
          "CloudCast",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        )
      ])),
    );
  }
}
