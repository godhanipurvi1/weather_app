import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/weather_provider.dart';
import 'home_page.dart';

class SavedLocationPage extends StatefulWidget {
  const SavedLocationPage({super.key});

  @override
  State<SavedLocationPage> createState() => _SavedLocationPageState();
}

class _SavedLocationPageState extends State<SavedLocationPage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<WeatherProvider>()
        .getIcon(context.watch<WeatherProvider>().weather!.weatherM![0].icon!);
    var providerW = context.watch<WeatherProvider>();
    var providerR = context.read<WeatherProvider>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                "pick location",
                style: TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
              alignment: Alignment.center,
              child: Text(
                  "         find the are or city that you want to know \n the detailed weather information for the current time"),
            ),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                //    color: const Color.fromRGBO(255, 255, 255, 0.4),
                height: 50,
                child: TextField(
                  controller: providerW.textEditingController,
                  decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
                      filled: true,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: IconButton(
                            onPressed: () {
                              String city =
                                  providerW.textEditingController!.text;
                              providerW.getWeather(
                                  //city
                                  );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                            icon: const Icon(Icons.search_rounded)),
                      ),
                      hintText: "search...",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                      )),
                ),
              ),
            ),
            if (providerW.cities.isEmpty)
              const Center(
                child: Text("you have not saved any cities"),
              )
            else
              Expanded(
                child: ListView.builder(
                    itemCount: providerW.cities.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: Key(providerW.cities[index].name.toString()),
                          onDismissed: (direction) {
                            providerW.removeFromCites(index);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    " ${providerW.cities[index].name.toString()} deleted")));
                          },
                          background: Container(
                            color: Colors.red,
                            child: const Icon(Icons.dangerous),
                          ),
                          child: ListTile(
                            trailing: IconButton(
                              icon: const Icon(Icons.dangerous),
                              onPressed: () {
                                providerW.removeFromCites(index);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        " ${providerW.cities[index].name.toString()} deleted")));
                              },
                            ),
                            // trailing: Image.asset(providerW.iconFullPath!,
                            //     height: 200),
                            title: Padding(
                              padding: const EdgeInsets.all(19.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      providerW.cities[index].name!.toString()),
                                  Text(
                                    "${providerW.celsius!.toInt()}°",
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                  Text(providerW.cities[index]!.weatherM![index]
                                      .description
                                      .toString()),
                                ],
                              ),
                            ),
                          ));
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
