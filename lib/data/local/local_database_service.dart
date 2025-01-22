import 'package:find_restaurant/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = "restaurant_database.db";
  static const int _databaseVersion = 1;
  static const String _tableName = 'restaurant';

  Future<void> createTables(Database database) async {
    await database.execute('''
      CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        pictureId TEXT,
        city TEXT,
        rating REAL
      )
    ''');
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await createTables(db);
      },
    );
  }

  Future<int> insertRestaurant(Restaurant restaurant) async {
    final db = await _initializeDb();
    final data = restaurant.toJson();
    final id = await db.insert(_tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Restaurant>> getRestaurants() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);
    return results.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Restaurant?> getRestaurantById(String id) async {
    final db = await _initializeDb();
    final results =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    if (results.isNotEmpty) {
      return Restaurant.fromJson(results.first);
    } else {
      return null;
    }
  }

  Future<int> deleteRestaurant(String id) async {
    final db = await _initializeDb();
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
