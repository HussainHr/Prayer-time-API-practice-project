import 'dart:convert';

import 'package:http/http.dart' as http;

import '../database_helper/database_helper.dart';
import '../database_helper/prayer_model.dart';

class ApiService {
  List<PrayerTime> prayerList = [];

  Future<List<PrayerTime>> fetchPrayerTime(String date) async {
    final prayerTime = await PrayerTimeDatabase.instance.getPrayerTime(date);

    var url =
        'http://api.aladhan.com/v1/calendarByAddress?address=Sultanahmet%20Mosque,%20Dhaka,%20Bangladeesh&method=19&month=02&year=2023';
    final response = await http.get(Uri.parse(url));
    date = "";
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body.toString());
      print(response.statusCode);
      print(json);
      // await PrayerTimeDatabase.instance.create(prayerTime);
      (json['data'] as List).map((e) {
        print(PrayerTime.fromJson(e));
        PrayerTimeDatabase.instance.create(PrayerTime.fromJson(e));
      }).toList();
      return prayerList;
    }
    // PrayerTimeDatabase.instance.create(PrayerTime.fromJson(json));
    // return prayerList;
    // }
    else {
      return prayerList;
    }
  }
}

 // if (prayerTime != null) {
    //   return prayerTime;
    // } else {
    //   final response = await http.get(Uri.parse(
    //       'http://api.aladhan.com/v1/calendarByCity?city=London&country=United%20Kingdom&method=2&month=${date.split('-')[1]}&year=${date.split('-')[0]}'));
    //   if (response.statusCode == 200) {
    //     final data = jsonDecode(response.body);
    //     final prayerTimeData = data['data'][int.parse(date.split('-')[2]) - 1];
    //     final prayerTime = PrayerTime.fromJson(prayerTimeData);
    //     await PrayerTimeDatabase.instance.create(prayerTime);
    //     return prayerTime;
    //   } else {
    //     throw Exception('Failed to fetch prayer time');
    //   }
    // }