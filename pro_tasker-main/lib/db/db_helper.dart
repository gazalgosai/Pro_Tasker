import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper{
  //database variable
  static Database? _db;
  //version
  static final int  _versoin = 1;
  //table name
  static final String _tableName = "tasks";

  //initialize database
  static Future<void> initDb() async {
    if(_db != null){
      return;
    }
    try{
      String _path = await  getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
       _path,
       version: _versoin,
       onCreate: (db,version){
         print("creating a new one");
         return  db.execute(
           "CREATE TABLE $_tableName("
               "id INTEGER PRIMARY KEY AUTOINCREMENT,"
               "title STRING, note TEXT,date STRING,"
               "startTime STRING, endTime STRING,"
               "remind INTEGER ,  repeat STRING,"
               "color INTEGER,"
               "isCompleted INTEGER )",

         );
       }
      );
    }catch(e){
      print(e);
    }
  }
  //insert
   static Future<int> insert(Task? task) async{
    print("insert function called");
    return await  _db?.insert(_tableName, task!.toJson())??1;
   }

   //select
   static Future<List<Map<String,dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName);
   }

   //delete
   static delete(Task task) async{
    await _db!.delete(_tableName,where: 'id=?',whereArgs: [task.id]);
   }

   //update complete field
   static update (int id) async {
    return await _db!.rawUpdate('''
        UPDATE tasks 
        SET isCompleted = ?
        WHERE id = ?
    ''',[1,id]);
   }

   //update all fields
   static updateall (Task? task , int id) async{
    print("update function called");
    return await _db!.rawUpdate('''
     UPDATE tasks
     SET title = ?, note = ? , date = ? , startTime = ? , endTime = ? , remind = ? , repeat = ? , color = ? 
     WHERE id = ?
    ''',[task?.title,task?.note,task?.date,task?.startTime,task?.endTime,task?.remind,task?.repeat,task?.color,id])??1;
   }
}