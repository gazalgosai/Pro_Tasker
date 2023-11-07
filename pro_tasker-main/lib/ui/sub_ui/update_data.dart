import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../controllers/task_controller.dart';
import '../../models/task.dart';
import '../main_home_page.dart';
import '../theme.dart';
import '../widgets/input_field.dart';

class Update_Page extends StatefulWidget {
   Update_Page( {Key? key , required this.id , required this.task}) : super(key: key);

  int id;
  Task task;
  @override
  State<Update_Page> createState() => _Update_PageState();
}

class _Update_PageState extends State<Update_Page> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _noteEditingController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String  _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  List<int> remindList = [5,10,15,20];

  String _selectedRepeat = "None";
  List<String> repeatList = ["None","Daily","Weekly","Monthly"];

  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _appBar(context),
        body: Container(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                MyInputField(title: "Title", hint: widget.task.title.toString()+"- [Update it]", controller: _titleEditingController, widget: null, ),

                MyInputField(title: "Note", hint: widget.task.note.toString()+"- [Update it]", controller: _noteEditingController, widget: null),

                MyInputField(
                    title: "Date", hint:widget.task.date.toString(),
                    controller: null,
                    widget: IconButton(
                      onPressed: () {
                        _getDateFromUser();
                      }, icon: Icon(Icons.calendar_today_outlined),color: Colors.grey,)
                ),

                Row(
                  children: [
                    Expanded(
                      child:
                      MyInputField(
                          title: "Start Time",
                          hint: widget.task.startTime.toString(),
                          controller: null,
                          widget: IconButton(
                            onPressed: () {
                              _getTimeFromUser(isStartTime: true);
                            }, icon: Icon(Icons.access_time_rounded),color: Colors.grey,)),
                    ),

                    SizedBox(width: 12,),

                    Expanded(
                      child:
                      MyInputField(
                          title: "End Time",
                          hint:widget.task.endTime.toString(),
                          controller: null,
                          widget: IconButton(
                            onPressed: () {
                              _getTimeFromUser(isStartTime: false);
                            }, icon: Icon(Icons.access_time_rounded),color: Colors.grey,)),
                    ),
                  ],
                ),

                MyInputField(
                    title: "Remind",
                    hint: "${widget.task.remind.toString()} minutes early",
                    controller: null,
                    widget: DropdownButton(
                      underline: Container(height: 0,),
                      items:  remindList.map<DropdownMenuItem<String>>(
                              (int value){
                            return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: Text(value.toString()));
                          }
                      ).toList(),
                      onChanged:(String? newValue){
                        setState(() {
                          _selectedRemind = int.parse(newValue!);
                        });
                      },
                      icon: Icon(Icons.keyboard_arrow_down,color:Colors.grey),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                    )
                ),

                MyInputField(
                    title: "Repeat",
                    hint:widget.task.repeat.toString(),
                    controller: null,
                    widget: DropdownButton(
                      underline: Container(height: 0,),
                      items:  repeatList.map<DropdownMenuItem<String>>(
                              (String? value){
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value!,style: TextStyle(color: Colors.grey),));
                          }
                      ).toList(),
                      onChanged:(String? newValue){
                        setState(() {
                          _selectedRepeat = newValue!;
                        });
                      },
                      icon: Icon(Icons.keyboard_arrow_down,color:Colors.grey),
                      iconSize: 32,
                      elevation: 4,
                      style: subTitleStyle,
                    )
                ),

                SizedBox(height: 18,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPallete(),
                    GestureDetector(
                      onTap: (){
                        _validateDate();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: PrimaryClr
                        ),
                        child: Text(
                          "Update Task",
                          style: TextStyle(
                            color: Colors.white,),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _validateDate(){
    if(_titleEditingController.text.isNotEmpty && _noteEditingController.text.isNotEmpty){
      //add to database
      _updateTaskToDb();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
      _update_msg();
    }
    else if(_titleEditingController.text.isEmpty || _noteEditingController.text.isEmpty){
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: RichText(text: TextSpan()) )
      // );
      Get.snackbar("Required", "All Fields are required !",
          snackPosition: SnackPosition.BOTTOM,
          // backgroundColor: Colors.red,
          backgroundColor: Get.isDarkMode?Colors.white:Colors.black,
          colorText: yellowClr,
          icon: Icon(Icons.warning_amber_outlined,color: yellowClr,)
      );
    }
  }
  _update_msg(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Update Task SucessFully"),
        backgroundColor: Colors.green,
      )
    );
  }
  _updateTaskToDb() async {
    int value = await _taskController.updateall(
        id: widget.id,
      task: Task(
        note: _noteEditingController.text,
              title : _titleEditingController.text,
              date : DateFormat.yMd().format(_selectedDate),
              startTime : _startTime,
              endTime : _endTime,
              remind : _selectedRemind,
              repeat : _selectedRepeat,
              color : _selectedColor,
              isCompleted : 0,
      )
    );
    print("Update id is: $value");
  }
  _colorPallete(){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",style: titleStyle,),

        SizedBox(height: 8.0,),

        Wrap(
          children: List<Widget>.generate(
              3,
                  (int index) =>  GestureDetector(
                onTap: (){
                  setState(() {
                    _selectedColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0 ? PrimaryClr:index == 1 ? pinkClr :yellowClr,
                    child: _selectedColor == index? Icon(Icons.done,color: Colors.white,size: 16,):Container(),

                  ),
                ),
              )),
        ),
      ],
    );
  }
  _appBar(BuildContext context){
    return AppBar(
      title: Text("Update Task",
        style: headingStyle,
      ),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {Get.back();},
        child: Icon(
          Icons.arrow_back,
          size: 20,
          color: Get.isDarkMode? Colors.white :Colors.black,),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await  showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));

    if (_pickerDate != null){
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
    else{
      print("Something is wrong");
    }
  }

  _getTimeFromUser({ required bool isStartTime}) async {
    var pickedTime = await _showTimePickerFun();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime  == null ){
      print("Time canceled");
    }
    else if(isStartTime == true){
      setState(() {
        _startTime  = _formatedTime;

      });
    }
    else if(isStartTime == false){
      setState(() {
        _endTime = _formatedTime;

      });
    }
  }

  _showTimePickerFun(){
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context, initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]
        )));
  }
}
