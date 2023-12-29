import 'package:crudsqlite/db/db_connection.dart';
import 'package:sqflite/sqlite_api.dart';

class Repository {
  late DBConnection dbConnection;
  Repository() {
    dbConnection = DBConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await dbConnection.setDatabase();
      return _database;
    }
  }

  //insert User
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //Read All Records
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  //Read by id Records
  readDataById(table, itemId) async {
    var connection = await database;
    return await connection?.query(table, where: 'id=?', whereArgs: [itemId]);
  }

  //update user
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: "id=?", whereArgs: [data['id']]);
  }

  //delete user
  deleteData(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}
