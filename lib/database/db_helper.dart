import 'package:sqflite/sqflite.dart' as db;
import 'package:path/path.dart' as paths;

class DBHelper {
  static db.Database? _dbHandle;

  static const String dbName = 'places.db';
  static const String tableName = 'Places';
  static const _sql =
      'CREATE TABLE $tableName (id INTEGER PRIMARY KEY autoincrement, title TEXT not null, imagePath TEXT not null,  longtitude REAL,latitude REAL)';

  static Future<db.Database?> openDatabase({
    required String dbName,
  }) async {
    final _path = await _constructPath(dbName);

    _dbHandle = await db.openDatabase(
      _path,
      onCreate: (db, _) async {
        await db.execute(_sql);
      },
      version: 1,
    );
    return _dbHandle;
  }

//save the place
  static Future<int> insert(
      {String dbName = dbName,
      String tableName = tableName,
      required Map<String, Object> placeList}) async {
    _dbHandle ??= await openDatabase(dbName: dbName);
    //Now try to save the record
    return await _dbHandle!.insert(
      tableName,
      placeList,
      conflictAlgorithm: db.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map>> select({
    String dbName = dbName,
    String tableName = tableName,
  }) async {
    _dbHandle ??= await openDatabase(dbName: dbName);

    // Get the records
    List<Map> _list = await _dbHandle!.rawQuery('SELECT * FROM $tableName');
    return _list;
  }

  static void deletePlace() {}

  static void closeDatabase() {
    if (_dbHandle != null) {
      _dbHandle!.close();
    }
  }

  static Future<String> _constructPath(String dbName) async {
    final String _sysPath = await db.getDatabasesPath();
    final _path = paths.join(_sysPath, dbName);
    return _path;
  }
}
