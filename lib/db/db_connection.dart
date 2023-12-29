import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = p.join(directory.path, "crud_user.db");
    var database =
        await openDatabase(path, version: 1, onCreate: createDatabase);
    return database;
  }

  Future<void> createDatabase(Database database, int version) async {
    String sql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, contact TEXT, description TEXT)";
    await database.execute(sql);
  }
}
