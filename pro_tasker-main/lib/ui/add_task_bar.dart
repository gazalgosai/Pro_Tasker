
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pro_tasker/controllers/task_controller.dart';
import 'package:pro_tasker/models/task.dart';
import 'package:pro_tasker/ui/home_page.dart';
import 'package:pro_tasker/ui/main_home_page.dart';
import 'package:pro_tasker/ui/theme.dart';
import 'package:pro_tasker/ui/theme.dart';
import 'package:pro_tasker/ui/widgets/input_field.dart';
import '../services/theme_services.dart';

extension TimeOfDayConvert on TimeOfDay{
  String to24hours(){
    final hour = this.hour.toString().padLeft(2,"0");
    final minute = this.minute.toString().padLeft(2,"0");
    return "$hour:$minute";
  }
}

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}
/* TODO: Dropdown button me size badhane ki hai*/

class _AddTaskPageState extends State<AddTaskPage> {
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
            //title
              MyInputField(title: "Title", hint: "Enter Your title", controller: _titleEditingController, widget: null, ),

             //note
             MyInputField(title: "Note", hint: "Enter Your Note", controller: _noteEditingController, widget: null),

             //date
             MyInputField(
                 title: "Date", hint: DateFormat.yMd().format(_selectedDate), 
                 controller: null,
                 widget: IconButton(
                   onPressed: () {
                    _getDateFromUser();
                 }, icon: const Icon(Icons.calendar_today_outlined),color: Colors.grey,)
             ),

              //start and end time
              Row(
                children: [
                  Expanded(
                      child:
                      MyInputField(
                          title: "Start Time",
                          hint: _startTime,
                          controller: null,
                          widget: IconButton(
                              onPressed: () {
                                 _getTimeFromUser(isStartTime: true);
                          }, icon: const Icon(Icons.access_time_rounded),color: Colors.grey,)),
                  ),

                  const SizedBox(width: 12,),

                  Expanded(
                    child:
                    MyInputField(
                        title: "End Time",
                        hint: _endTime,
                        controller: null,
                        widget: IconButton(
                          onPressed: () {
                              _getTimeFromUser(isStartTime: false);
                          }, icon: const Icon(Icons.access_time_rounded),color: Colors.grey,)),
                  ),
                ],
              ),

              //remind
              MyInputField(
                  title: "Remind",
                  hint: "$_selectedRemind minutes early",
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
                    icon: const Icon(Icons.keyboard_arrow_down,color:Colors.grey),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                  )
              ),

              //repeat
              MyInputField(
                  title: "Repeat",
                  hint: "$_selectedRepeat",
                  controller: null,
                  widget: DropdownButton(
                    underline: Container(height: 0,),
                    items:  repeatList.map<DropdownMenuItem<String>>(
                            (String? value){
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value!,));
                        }
                    ).toList(),
                    onChanged:(String? newValue){
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    icon: const Icon(Icons.keyboard_arrow_down,color:Colors.grey),
                    iconSize: 32,
                    elevation: 4,
                    style: subTitleStyle,
                  )
              ),

              const SizedBox(height: 18,),

              //color and create task
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
                      child: const Text(
                        "Create Task",
                        style: TextStyle(
                          color: Colors.white,),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    ),
    );
  }

  //validate date
  _validateDate(){
      if(_titleEditingController.text.isNotEmpty && _noteEditingController.text.isNotEmpty){
        //add to database
        _addTaskToDb();
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home(),));
        _add_msg();
      }
      else if(_titleEditingController.text.isEmpty || _noteEditingController.text.isEmpty){
         Get.snackbar("Required", "All Fields are required !",
         snackPosition: SnackPosition.BOTTOM,
           // backgroundColor: Colors.red,
            backgroundColor: Get.isDarkMode?Colors.white:Colors.black,
           colorText: yellowClr,
           icon: const Icon(Icons.warning_amber_outlined,color: yellowClr,)
         );
      }
  }
  _add_msg(){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Insert Task SucessFully"),
          backgroundColor: Colors.green,
        )
    );
  }
  // add task
  _addTaskToDb() async {
    int value = await _taskController.addTask(
        task:Task(
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
print("My id is : $value");
  }

  //color pallete logic
  _colorPallete(){
    return   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Color",style: titleStyle,),

        const SizedBox(height: 8.0,),

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
                    child: _selectedColor == index? const Icon(Icons.done,color: Colors.white,size: 16,):Container(),

                  ),
                ),
              )),
        ),
      ],
    );
  }

  //app bar
  _appBar(BuildContext context){
    return AppBar(
      title: Text("Add Task",
        style: headingStyle,
      ),
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {navigator?.pop();},
        child: Icon(
          Icons.arrow_back,
          size: 20,
          color: Get.isDarkMode? Colors.white :Colors.black,),
      ),
    );
  }

  //get date
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

  // get start and end time
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

  //time picker
  _showTimePickerFun(){
    return showTimePicker(
         initialEntryMode: TimePickerEntryMode.input,
        context: context, initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]
        )));
  }
}
