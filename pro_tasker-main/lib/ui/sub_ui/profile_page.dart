import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_tasker/ui/home_page.dart';
import 'package:pro_tasker/ui/sub_ui/login.dart';

import '../main_home_page.dart';
import '../theme.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key,}) : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: _appbar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage("images/user_logo.webp"),maxRadius: 80,
              ),


              const SizedBox(height: 30,),
              InkWell(
                onTap: () {
                      showDialog(context: context,
                          builder:
                      (context) {
                        return AlertDialog(
                          title: const Text("Personal Info"),
                          icon:  Icon(Icons.email_outlined,color: Get.isDarkMode?Colors.white:PrimaryClr,),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            Align(
                             alignment: Alignment.center,
                              child: Text("Email: ${FirebaseAuth.instance.currentUser?.email.toString()}"
                                ,style: titleStyle.copyWith(fontSize: 17),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(onPressed: () =>
                                  Navigator.pop(context),
                                style: ButtonStyle(
                                    backgroundColor: const MaterialStatePropertyAll(bluishClr),
                                    minimumSize: const MaterialStatePropertyAll(Size(70,40)),
                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))

                                ), child: Text("OK",style: titleStyle.copyWith(color: Colors.white),),
                              ),
                            )
                          ],
                        );
                      },);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Get.isDarkMode? Colors.white:Colors.black,style: BorderStyle.solid )
                  ),
                  child: const Text("Personal Info"),
                ),
              ),

              const SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  showDialog(context: context,
                    builder:
                        (context) {
                      return AlertDialog(
                        title: const Text("Developer"),
                        icon:  Icon(Icons.person,color: Get.isDarkMode?Colors.white:PrimaryClr,),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("Name: Gazal p. Gauswami \nEducation: BCA"
                              ,style: titleStyle.copyWith(fontSize: 17),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(onPressed: () =>
                                Navigator.pop(context),
                              style: ButtonStyle(
                                  backgroundColor: const MaterialStatePropertyAll(bluishClr),
                                  minimumSize: const MaterialStatePropertyAll(Size(70,40)),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))

                              ), child: Text("OK",style: titleStyle.copyWith(color: Colors.white),),
                            ),
                          )
                        ],
                      );
                    },);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Get.isDarkMode? Colors.white:Colors.black,style: BorderStyle.solid )
                  ),
                  child: const Text("Know About Devloper"),
                ),
              ),

              const SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  showDialog(context: context,
                    builder:
                        (context) {
                      return AlertDialog(
                        title: const Text("Help"),
                        icon:  Icon(Icons.help_outline,color: Get.isDarkMode?Colors.white:PrimaryClr,),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("1.You will see all screen navigation button\n"
                              "2.See all task in calender screen with update and delete it \n"
                              "3.You are add Task By click on center add icon button \n"
                              "4.Get know how to manage task by read screen\n"
                              "5.You are see your profile with extra option"
                              ,style: titleStyle.copyWith(fontSize: 17),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(onPressed: () =>
                                Navigator.pop(context),
                              style: ButtonStyle(
                                  backgroundColor: const MaterialStatePropertyAll(bluishClr),
                                  minimumSize: const MaterialStatePropertyAll(Size(70,40)),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))

                              ), child: Text("OK",style: titleStyle.copyWith(color: Colors.white),),
                            ),
                          )
                        ],
                      );
                    },);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Get.isDarkMode? Colors.white:Colors.black,style: BorderStyle.solid )
                  ),
                  child: const Text("Help"),
                ),
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  showDialog(context: context,
                    builder:
                        (context) {
                      return AlertDialog(
                        title: const Text("Feedback"),
                        icon:Icon(Icons.feedback_outlined,color: Get.isDarkMode?Colors.white:PrimaryClr,),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          Align(
                            alignment: Alignment.center,
                            child: Text("Write Your Feedback"
                              ,style: titleStyle.copyWith(fontSize: 17),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          const Align(
                            alignment: Alignment.center,
                            child: TextField(
                              decoration: InputDecoration(hintText: "Write Your Feedback here",border: OutlineInputBorder()),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(onPressed: () =>
                                Navigator.pop(context),
                              style: ButtonStyle(
                                  backgroundColor: const MaterialStatePropertyAll(bluishClr),
                                  minimumSize: const MaterialStatePropertyAll(Size(70,40)),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))

                              ), child: Text("OK",style: titleStyle.copyWith(color: Colors.white),),
                            ),
                          )
                        ],
                      );
                    },);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Get.isDarkMode? Colors.white:Colors.black,style: BorderStyle.solid )
                  ),
                  child: const Text("Feedback"),
                ),
              ),
              const SizedBox(height: 30,),

              ElevatedButton(onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Login_Page(),));
              },
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(bluishClr),
                    minimumSize: const MaterialStatePropertyAll(Size(double.infinity,50)),
shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))

                  ),
                  child: Text("Logout",style: titleStyle.copyWith(color: Colors.white,fontWeight: FontWeight.bold),)),

              const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    ));
  }
  _appbar(){
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      title: Text(
        "Additional Information",
        style: subHeadingStyle.copyWith(color: Get.isDarkMode?Colors.white:Colors.black),
      ),
      elevation: 0,
      leading: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home(),));
          },
        child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Get.isDarkMode? Colors.white :Colors.black,),
      ),
    );
  }
}
