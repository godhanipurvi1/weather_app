import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/saved_location_page.dart';
import 'package:weather/provider/weather_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    String city = context.read<WeatherProvider>().textEditingController!.text;
    context.read<WeatherProvider>().getWeather(
        //  city
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerW = context.watch<WeatherProvider>();
    var providerR = context.read<WeatherProvider>();

    return Scaffold(
        body: providerW.weather == null
            ? Container(
                child: Text("Nothing to show"),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(children: [
                      // Image.asset(providerW.imageFullPath.toString(),
                      //     fit: BoxFit.cover),
                      // const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SavedLocationPage()));
                                      },
                                      icon: const Icon(Icons.search)),
                                  const SizedBox(height: 20),
                                  IconButton(
                                      onPressed: () {
                                        providerR
                                            .addToSavedList(providerW.weather!);
                                        print("add city");
                                      },
                                      icon: const Icon(
                                          Icons.bookmark_add_outlined)),
                                ],
                              ),
                            ),
                            Text(
                              providerW.weather?.name?.toString() ?? "no data",
                              style: const TextStyle(fontSize: 30),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(providerW.formattedDate?.toString() ??
                                "no date"),
                            const SizedBox(height: 20),
                            Image.asset(
                              providerW.iconFullPath.toString(),
                              height: 100,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              "${providerW.celsius!.toInt().toString()}°",
                              style: const TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            Text(providerW.weather?.weatherM?[0].description
                                    .toString() ??
                                ""),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 78,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: providerW.myWhite,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                        height: 50,
                                        width: 100,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(20),
                                        //   color: providerW.myWhite,
                                        // ),
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text("clouds"),
                                            ),
                                            Text(providerW
                                                    .weather!.cloudModel!.all
                                                    ?.toString() ??
                                                "null"),
                                          ],
                                        )),
                                    SizedBox(
                                        height: 50,
                                        width: 100,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(20),
                                        //   color: providerW.myWhite,
                                        // ),
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text("wind"),
                                            ),
                                            Text(
                                                "${providerW.weather!.windModel!.speed.toString()} m/s"),
                                          ],
                                        )),
                                    SizedBox(
                                        height: 50,
                                        width: 100,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(20),
                                        //   color: providerW.myWhite,
                                        // ),
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Text("temp"),
                                            ),
                                            Text(
                                                "${providerW.weather!.mainModel!.humidity.toString()}%"),
                                            Container()
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  color: providerW.myWhite,
                                  borderRadius: BorderRadius.circular(21),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              const Text("pressure"),
                                              const SizedBox(height: 10),
                                              Text(
                                                  "${providerW.weather!.mainModel!.pressure.toString() ?? ""} hPA"),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text("humidity"),
                                              const SizedBox(height: 10),
                                              Text(
                                                  "${providerW.weather!.mainModel!.humidity.toString() ?? ""}%"),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              const Text("min temp"),
                                              const SizedBox(height: 10),
                                              Text(
                                                  "${providerW.weather!.mainModel!.temp_min.toString() ?? ""}%"),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text("max temp"),
                                              const SizedBox(height: 10),
                                              Text(
                                                  "${providerW.weather!.mainModel!.temp_max.toString() ?? ""}%"),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ])
                  ],
                ),
              )
        // Center(
        //   child: providerW.pages[providerW.selectedIndex],
        // ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.only(left: 39.0, right: 39, bottom: 30),
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(40),
        //     child: BottomNavigationBar(
        //       currentIndex: providerW.selectedIndex,
        //       onTap: (index) {
        //         providerR.onItemTap(index, context);
        //       },
        //       iconSize: 28,
        //       selectedFontSize: 0,
        //       unselectedFontSize: 0,
        //       backgroundColor: const Color.fromRGBO(255, 255, 255, 0.4),
        //       type: BottomNavigationBarType.fixed,
        //       unselectedItemColor: const Color.fromRGBO(219, 227, 232, 1.0),
        //       selectedItemColor: const Color.fromRGBO(6, 8, 32, 1),
        //       items: providerW.icons
        //           .map((e) => BottomNavigationBarItem(
        //                 icon: Padding(
        //                   padding: const EdgeInsets.all(20.0),
        //                   child: Icon(e),
        //                 ),
        //                 label: "",
        //               ))
        //           .toList(),
        //     ),
        //   ),
        // ),
        );
  }
}
