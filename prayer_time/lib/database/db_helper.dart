import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prayer_time/Model/prayer_model.dart';
import 'package:sqflite/sqflite.dart';

class PrayerTimeDatabase {
  static final PrayerTimeDatabase instance = PrayerTimeDatabase._init();

  static Database? _database;

  PrayerTimeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('prayer_times.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE prayer_times (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TEXT,
  fajr TEXT,
  sunrise TEXT,
  dhuhr TEXT,
  asr TEXT,
  maghrib TEXT,
  isha TEXT
)
''');
  }

  Future<PrayerTime> create(PrayerTime prayerTime) async {
    final db = await instance.database;
    final id = await db.insert('prayer_times', prayerTime.toJson());
    return prayerTime;
  }

  Future<PrayerTime?> getPrayerTime(String date) async {
    final db = await instance.database;
    final maps = await db.query(
      'prayer_times',
      where: 'date = ?',
      whereArgs: [date],
    );
    if (maps.isNotEmpty) {
      return PrayerTime.fromJson(maps.first);
    } else {
      return null;
    }
  }
}
