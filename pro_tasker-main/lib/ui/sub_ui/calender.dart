import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pro_tasker/ui/sub_ui/update_data.dart';
import 'package:pro_tasker/ui/theme.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../../services/notification_services.dart';
import '../add_task_bar.dart';
import '../home_page.dart';
import '../main_home_page.dart';
import '../widgets/task_tile.dart';

class Calender_Page extends StatefulWidget {
  const Calender_Page({Key? key}) : super(key: key);

  @override
  State<Calender_Page> createState() => _Calender_PageState();
}

class _Calender_PageState extends State<Calender_Page> {

  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;
  @override
  void initState() {
    ///TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appbar(),
      body: Column(
        children: [
          _addTaskBar(),
          //Calaender
          _addDateBar(),
          SizedBox(height: 10,),
          //TaskList
          _showTasks(),
        ],
      ),
    ));
  }
  _showTasks(){
    _taskController.getTasks();
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (context, index) {
            print(_taskController.taskList.length);
            Task task = _taskController.taskList[index];
            print(task.toJson());


            if(task.repeat=="Daily"){

              DateTime date = DateFormat.Hm().parse(task.startTime.toString());
              print(date);
              var myTime = DateFormat("HH:mm").format(date);
              print(myTime);
              notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]),
                int.parse(myTime.toString().split(":")[1]),
                task,
              );

              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context,task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            if(task.date==DateFormat.yMd().format(_selectedDate)){
              DateTime date = DateFormat.Hm().parse(task.startTime.toString());
              print(date);
              var myTime = DateFormat("HH:mm").format(date);
              print(myTime);
              notifyHelper.scheduledNotification(
                int.parse(myTime.toString().split(":")[0]),
                int.parse(myTime.toString().split(":")[1]),
                task,
              );

              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context,task);
                          },
                          child: TaskTile(task),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }else{
              return Container();
            }
          },
        );
      }),
    );
  }
  _appbar(){
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      title: Text("Task Scheduale",
        style: subHeadingStyle.copyWith(color: Get.isDarkMode?Colors.white:Colors.black),
      ),
      elevation: 0,
      leading: InkWell(
        onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));},
        child: Icon(
          Icons.arrow_back,
          size: 20,
          color: Get.isDarkMode? Colors.white :Colors.black,),
      ),
   // actions: [
   //    Text("Task Scheduale", style: headingStyle,),
   // ],
    );
  }
  _showBottomSheet(BuildContext context,Task task){
    Get.bottomSheet(
        Container(
          padding: EdgeInsets.only(top:4 ),
          height: task.isCompleted == 1?
          MediaQuery.of(context).size.height*0.40:
          MediaQuery.of(context).size.height*0.52,
          color: Get.isDarkMode?darkGreyClr:Colors.white,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300],
                ),
              ),
              Spacer(),
              // SizedBox(height: 10,),
              task.isCompleted==1?Container():
              _bottomSheetButton(label: "Task Completed",
                  onTap: (){
                    _taskController.markTaskCompleted(task.id!);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Task Completed!"),
                          backgroundColor: Colors.green,
                        )
                    );
                    Get.back();},
                  clr: PrimaryClr,context :context),

              SizedBox(height: 15,),

              _bottomSheetButton(
                  label: "Delete Task",
                  onTap: () {
                    _taskController.delete(task);
                    ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text("Delete Task Sucessfully"),
              backgroundColor: Colors.green,
              )
                  );
                    Get.back();
                  },
                  clr: Colors.red[300]!, context: context),

              SizedBox(height: 25,),

              _bottomSheetButton(label: "Update Task",
                  onTap: () {
                    // _taskController.updateall(task:task ,id: task.id??0);
                    navigator?.push(MaterialPageRoute(builder: (context) => Update_Page(id:task.id??0,task: task,),));
                  }, clr: yellowClr, context: context),

              SizedBox(height: 25,),

              _bottomSheetButton(label: "Close", onTap: (){Get.back();}, clr: Colors.red[300]!, context: context , isClose: true),

              SizedBox(height: 10,)
            ],
          ),
        )
    );
  }
  _bottomSheetButton({ required String label,required Function()? onTap,required Color clr, bool isClose=false,required BuildContext context}){
    return GestureDetector(
      onTap: onTap,
      child:  Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,

        decoration: BoxDecoration(
          // color: isClose==true?Get.isDarkMode?Colors.grey[600]:Colors.grey[300]:clr,
          color: isClose==true?Get.isDarkMode?Colors.transparent:Colors.transparent:clr,
          border: Border.all(width: 2,
            color: isClose == true ? Get.isDarkMode?Colors.grey[600]!:Colors.grey[400]! : clr,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: isClose == true ?titleStyle:titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
  _addDateBar(){
    return  Container(
      margin: const EdgeInsets.only(top: 20,left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: PrimaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey
          ),
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate=date;
          });
        },
      ),
    );
  }
  _addTaskBar(){
    return  Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today",
                  style: headingStyle,
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: () async {
          //     await
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskPage(),));
          //     _taskController.getTasks();
          //   },
          //   child: Container(
          //     alignment: Alignment.center,
          //     width: 120,
          //     height: 60,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: PrimaryClr
          //     ),
          //     child: Text(
          //       "Add Task",
          //       style: TextStyle(
          //         color: Colors.white,),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
