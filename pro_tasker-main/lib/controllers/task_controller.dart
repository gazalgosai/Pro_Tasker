import 'package:get/get.dart';
import 'package:pro_tasker/db/db_helper.dart';

import '../models/task.dart';

class TaskController extends GetxController{

  @override
  void onReady(){
    super.onReady();
  }

  var  taskList  = <Task>[].obs;

  //Add Task
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  //Get all data from table
 void getTasks() async {
    List<Map<String,dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
 }

 //Delete Task
 void delete(Task task){
      DBHelper.delete(task);
    getTasks();
  }

  //Update Complete Task Field
  Future<void> markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }

  //For Update All Fields of Task
  Future updateall({Task? task , required int id}) async{
    return await DBHelper.updateall(task,id);
    getTasks();
  }


}