// todo-01-local-03: create a service that handle a database service
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'restaurant-app.db';
  static const String _tableName = 'restaurant';
  static const int _version = 1;

  Future<void> createTables(Database database) async {
    await database.execute(
      """CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY,
        name TEXT,
        description TEXT,
        city TEXT,
        address TEXT,
        pictureId TEXT,
        rating DOUBLE,
      )
      """,
    );
  }

  Future<Database> _initializeDb() async {
    return openDatabase(
      _databaseName,
      version: _version,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  Future<int> insertItem(RestaurantDetail restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  // todo-01-local-08: read all items
  Future<List<Tourism>> getAllItems() async {
    final db = await _initializeDb();
    final results = await db.query(_tableName);

    return results.map((result) => Tourism.fromJson(result)).toList();
  }

  // todo-01-local-09: get a single item by id
  Future<Tourism> getItemById(int id) async {
    final db = await _initializeDb();
    final results =
    await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    return results.map((result) => Tourism.fromJson(result)).first;
  }

  // todo-01-local-10: delete an item by id
  Future<int> removeItem(int id) async {
    final db = await _initializeDb();

    final result =
    await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
    return result;
  }
}
