import 'package:family/model/device.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  Database? _database;

  Future<Database> initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'device_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE devices(device_id TEXT PRIMARY KEY, name TEXT, ip TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDB();
    }
    return _database!;
  }

  Future<void> insertDevice(Device device) async {
    final db = await database;
    await db.insert(
      'devices',
      device.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Device?> getDevice(String ip) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'devices',
      where: 'ip = ?',
      whereArgs: [ip],
    );
    return Device(
      maps[0]['device_id'],
      maps[0]['name'],
      maps[0]['ip'],
    );
  }

  Future<List<Device>> getDevices() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('devices');
    return List.generate(maps.length, (i) {
      return Device(
        maps[i]['device_id'],
        maps[i]['name'],
        maps[i]['ip'],
      );
    });
  }
}
