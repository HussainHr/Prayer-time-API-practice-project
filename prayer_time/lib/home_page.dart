import 'package:flutter/material.dart';
import 'package:prayer_time/database/api_service.dart';

import 'Model/prayer_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Prayer Times'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: apiService.fetchPrayerTime(DateTime.now().toString()),
              builder:
                  (BuildContext context, AsyncSnapshot<PrayerTime> snapshot) {
                // apiService.fetchPrayerTime(DateTime.now().toString());
                print(snapshot.data);
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(snapshot.data!.data![index].timings!.fajr
                                .toString()),
                          ],
                        );
                      });
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }
}
