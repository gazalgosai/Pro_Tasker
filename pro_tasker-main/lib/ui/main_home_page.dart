import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pro_tasker/ui/add_task_bar.dart';
import 'package:pro_tasker/ui/home_page.dart';
import 'package:pro_tasker/ui/sub_ui/calender.dart';
import 'package:pro_tasker/ui/sub_ui/chat_screen.dart';
import 'package:pro_tasker/ui/sub_ui/profile_page.dart';
import 'package:pro_tasker/ui/sub_ui/read.dart';
import 'package:pro_tasker/ui/theme.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //to handle which item is currently selected in the bottom app bar
  int selectedIndex = 0;

  final pages = [
    const HomePage(),//0
    const AddTaskPage(),//1
    const Calender_Page(),//2
    const Profile_Page(),//3
    const Read_Page(),//4
  ];
  String text = "Home";

  //call this method on click of each bottom app bar item to update the screen
  void updateTabSelection(int index,String buttonText){
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child:
        Scaffold(
          backgroundColor: context.theme.backgroundColor,
      resizeToAvoidBottomInset: false,

       //select index body page
       body: pages[
         selectedIndex
       ] ,

      //floating action button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: PrimaryClr,
        foregroundColor: Colors.white,
        onPressed: (){
          setState(() {
           updateTabSelection(1, "Add TAsk");
          });
        },
        tooltip: "ADD TASK",
        child: Icon(Icons.add),
        elevation: 4.0,
      ),


      ///bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: context.theme.backgroundColor,
        child: Container(
          margin: EdgeInsets.only(left: 12.0,right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///home scrren
              IconButton(onPressed: () {
                updateTabSelection(0, "Home");
              },
                   iconSize: 27.0,
                    icon: selectedIndex == 0 ? 
                        CircleAvatar(child: Image(image: AssetImage("images/609803.png"),fit: BoxFit.cover),backgroundColor: Colors.transparent,):
                        Icon(Icons.home_rounded,color: Colors.grey.shade500,)
              ),

              ///calender screen
              IconButton(onPressed: () {
                updateTabSelection(2, "Calendar");
              },
                  iconSize: 27.0 ,
                  icon: selectedIndex == 2 ?
                  CircleAvatar(child: Image(image: AssetImage("images/ci.png"),fit: BoxFit.cover),backgroundColor: Colors.transparent,):
                  Icon(Icons.calendar_today_rounded,color: Colors.grey.shade500,)
              ),

              ///read screen
              IconButton(onPressed: () async {
                updateTabSelection(4, "READ");
              },
                iconSize: 27.0,
                icon: selectedIndex == 4 ?
                CircleAvatar(child: Image(image: AssetImage("images/3145765.png"),fit: BoxFit.cover),backgroundColor: Colors.transparent,):
                Icon(Icons.menu_book_sharp,color: Colors.grey.shade500,)
              ),

              ///user screen
              IconButton(onPressed: () {
                updateTabSelection(3, "USER");
              },
                iconSize: 27.0,
                icon: selectedIndex == 3 ?
                CircleAvatar(child: Image(image: AssetImage("images/prof.png"),fit: BoxFit.cover),backgroundColor: Colors.transparent,):
                Icon(Icons.person,color: Colors.grey.shade500,)
              ),


            ],
          ),
        ),
      ),
    ),
    );
  }

}
