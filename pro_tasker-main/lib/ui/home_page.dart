import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_tasker/controllers/task_controller.dart';
import 'package:pro_tasker/services/notification_services.dart';
import 'package:pro_tasker/services/theme_services.dart';
import 'package:intl/intl.dart';
import 'package:pro_tasker/ui/add_task_bar.dart';
import 'package:pro_tasker/ui/sub_ui/calender.dart';
import 'package:pro_tasker/ui/sub_ui/profile_page.dart';
import 'package:pro_tasker/ui/theme.dart';
import 'package:pro_tasker/ui/widgets/button.dart';
import 'package:pro_tasker/ui/widgets/task_tile.dart';
import 'package:pro_tasker/models/task.dart';
import 'package:pro_tasker/ui/sub_ui/read.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  final _taskController = Get.put(TaskController());
  var notifyHelper;
  @override
  void initState(){
    ///TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
  }
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(child:
      Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(),
      body:  SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: [
                //TaskBar (Date,Today)
               _addTaskBar(),
                const SizedBox(height: 10,),
                const SizedBox(height: 20,),
                first_row(),
                // SizedBox(height: 10,),
                second_row(),
              ],
            ),
        ),
      ),
      ),
    );
  }
  first_row(){
    return Row(
      children: [
        ///show task
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Calender_Page(),));
            },
            child: Container(
              width: 160,
              height: 165,

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1,strokeAlign: StrokeAlign.outside,color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(

                children:  [
                const Align(alignment: Alignment.topCenter,child: Image(image: AssetImage("images/app.webp"),
                  height:135,alignment: Alignment.center,fit: BoxFit.cover,)
                ),
                  Align(alignment:Alignment.bottomCenter,child:  Text("Show Task",style: titleStyle.copyWith(color: Colors.black))),
                ],
              )
            ),
          ),
        ),

        ///show profile
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap:  () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile_Page(),));
            },
            child: Container(
                width: 160,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,strokeAlign: StrokeAlign.outside,color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children:  [
                    const Align(alignment: Alignment.topCenter,child: Image(image: AssetImage("images/profile.webp"),height: 135)),
                    Align(alignment:Alignment.bottomCenter,child: Text("Show Profile",style: titleStyle.copyWith(color: Colors.black)),),
                  ],
                )
            ),
          ),
        ),
      ],
    );
  }
  second_row(){
    return Row(
      children: [
        /// add task
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTaskPage(),));
            },
            child: Container(
                width: 160,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,strokeAlign: StrokeAlign.outside,color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
    const Align(alignment: Alignment.topCenter,child:Image(image: AssetImage("images/addtask.webp"),
      height: 135,
      alignment: Alignment.center,fit: BoxFit.cover,)),
                    Align(alignment:Alignment.bottomCenter,child:Text("Add Task",style: titleStyle.copyWith(color: Colors.black)))
                  ],
                )
            ),
          ),
        ),

        ///read page
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Read_Page(),));
            },
            child: Container(
                width: 160,
                height: 165,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1,strokeAlign: StrokeAlign.outside,color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  children: [
                    const Align(alignment: Alignment.topCenter,child:Image(image: AssetImage("images/read.webp"),
                      height: 135,
                      alignment: Alignment.center,fit: BoxFit.cover,)),
                    Align(alignment:Alignment.bottomCenter,child:Text("Library",style: titleStyle.copyWith(color: Colors.black)))
                  ],
                )
            ),
          ),
        ),
      ],
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
          // onTap: () async {
          //   await
          //   Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTaskPage(),));
          //   _taskController.getTasks();
          //   },
          // child: Container(
          //               alignment: Alignment.center,
          //               width: 120,
          //               height: 60,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(20),
          //                   color: PrimaryClr
          //          ),
          //   child: const Text(
          //                 "Add Task",
          //               style: TextStyle(
          //               color: Colors.white,),
          //      ),
          //   ),
          // ),
        ],
      ),
    );
  }
  _appBar(){
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeServices().switchTheme();
          notifyHelper.displayNotification(
            title: "Theme Changed",
            body : Get.isDarkMode?  "Activated Light Theme": "Activated Dark Theme"
          );

        },
        child: Icon(
          Get.isDarkMode? Icons.wb_sunny_outlined:Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode? Colors.white :Colors.black,),
      ),
      actions: [
        InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile_Page(),));
          },
          child: CircleAvatar(
            backgroundColor: Get.isDarkMode?darkGreyClr:Colors.white,
            //You can also give asset image
            child: Icon(
              Icons.menu_outlined
            ,color: Get.isDarkMode?Colors.white:darkGreyClr,
            ),
          ),
        ),

        const SizedBox(width: 20,),
      ],
    );
  }
}
