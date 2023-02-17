import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:prayer_time/Model/prayer_model.dart';
import 'db_helper.dart';

class ApiService {
  Future<PrayerTime> fetchPrayerTime(String date) async {
    final prayerTime = await PrayerTimeDatabase.instance.getPrayerTime(date);
    print('hi');
    if (prayerTime != null) {
      return prayerTime;
    } else {
      final response = await http.get(Uri.parse(
          'http://api.aladhan.com/v1/calendarByCity?city=London&country=United%20Kingdom&method=2&month=${date.split('-')[1]}&year=${date.split('-')[0]}'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prayerTimeData = data['data'][int.parse(date.split('-')[2]) - 1];
        final prayerTime = PrayerTime.fromJson(prayerTimeData);
        await PrayerTimeDatabase.instance.create(prayerTime);
        return prayerTime;
      } else {
        throw Exception('Failed to fetch prayer time');
      }
    }
  }
}
