import 'package:kamelection/utility/sqlite_helper.dart';

class MyTest {
  Future<Null> readSQLite() async{
  await SQLiteHelper().readAllData().then((value) {
    print('ขนาดของข้อมูล ==>> ${value.length}');
  });
}
}