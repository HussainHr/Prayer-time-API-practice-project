import 'dart:convert';

import 'package:prayer_time_apllication/database_helper/prayer_model.dart';
import 'package:http/http.dart' as http;

class PrayerTimesApi {
  Future<PrayerTime> getPrayerTime() async {
    var url =
        'http://api.aladhan.com/v1/calendarByAddress?address=Dhaka%20Mosque,%20Dhaka,%20Bangladesh&method=17&month=02&year=2023';
    print('this is hussain');
    final response = await http.get(Uri.parse(url));
    print('this is body');
    if (response.statusCode == 200) {
      print('hw are you');
      var data = jsonDecode(response.body.toString());
      return PrayerTime.fromJson(data);
    } else {
      throw Exception('error');
    }
  }
}
