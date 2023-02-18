import 'package:flutter/material.dart';
import 'package:prayer_time_apllication/api_service/prayer_api_service.dart';
import 'package:prayer_time_apllication/api_service/prayer_time_api.dart';
import 'package:prayer_time_apllication/database_helper/database_helper.dart';

import '../database_helper/prayer_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();
  PrayerTimesApi pr = PrayerTimesApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Prayer Times'),
      ),
      body: FutureBuilder(
        future: apiService.fetchPrayerTime(DateTime.now().toString()),
        //future: pr.getPrayerTime(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PrayerTime>> snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return Card(
                      child: ListTile(
                          title: Text(
                              snapshot.data![index].timings!.fajr.toString())));
                }));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     ElevatedButton(
      //       onPressed: (() {
      //         apiService.fetchPrayerTime(DateTime.now().toString());
      //       }),
      //       child: Text("Click me"),
      //     ),
      //     ElevatedButton(
      //       onPressed: (() {
      //         PrayerTimeDatabase.instance
      //             .getPrayerTime(DateTime.now().toString());
      //       }),
      //       child: Text("Show"),
      //     ),
      //   ],
      // ),
    );
  }
}
