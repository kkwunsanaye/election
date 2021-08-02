import 'package:kamelection/model/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'kamElection.db';
  final String nameTable = 'chooseTable';
  final int version = 1;

  final String colId = 'id';
  final String colIdOtp = 'idOtp';
  final String colChoiceChooseId = 'choiceChooseId';

  SQLiteHelper() {
    initialDatabase();
  }

  Future<Null> initialDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $nameTable ($colId INTEGER PRIMARY KEY, $colIdOtp TEXT, $colChoiceChooseId TEXT)');
      },
      version: version,
    );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<Null> inserValueToSQLite(SQLiteModel sqLiteModel) async {
    Database database = await connectedDatabase();
    try {
      database.insert(
        nameTable,
        sqLiteModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('######## insert Value at id = ${sqLiteModel.idOtp} ##########');
    } catch (e) {}
  }
Future<List<SQLiteModel>> readAllData()async{
Database database = await connectedDatabase();
List<SQLiteModel> list = [];
List <Map<String, dynamic>> maps = await database.query(nameTable); 
for (var item in maps) {
  SQLiteModel model = SQLiteModel.fromMap(item);
  list.add(model);
}
return list;

}

Future<Null>deleteAllData()async{
  Database database = await connectedDatabase();
  await database.delete(nameTable);
}
}
