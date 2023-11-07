import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_tasker/ui/sub_ui/signup.dart';
import 'package:pro_tasker/ui/theme.dart';

import '../main_home_page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  final _formKey = GlobalKey<FormState>();
  final  TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center(

          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //images
                    Image(image: AssetImage("images/login.webp"),height: 250),

                  SizedBox(height: 15,),

                  //heading
                    Text("Welcome Back",style: headingStyle,),

                  //sub-heading
                    Text("Login to continue",style: titleStyle,),

                   SizedBox(height: 15,),
                   //email
                    TextFormField(
                    controller: _email,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please Enter Email";
                      }
                      return null;
                    },
                    decoration:InputDecoration(
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(5), ),
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                    ),
                ),


                    SizedBox(height: 15,),

                    //password
                TextFormField(
                        controller: _pass,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if(value!.isEmpty || value!.length != 6){
                            return "Please Enter Six Character Password";
                          }
                          return null;
                        },
                        decoration:InputDecoration(
                          border:OutlineInputBorder(borderRadius:BorderRadius.circular(5), ),
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Password",
                        ),
                    ),


                SizedBox(height: 20,),

                ElevatedButton(
                    onPressed: () {
                  if(_formKey.currentState!.validate()){
                    login();
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
                    // ScaffoldMessenger.of(context).showSnackBar(_snakbar());
                  }
                  else{
                    debugPrint('Log: Email is empty or password is invalid');
                  }
                },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(bluishClr),
                      minimumSize: MaterialStatePropertyAll(Size(150,60)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)))
                    ),
                    child: Text("Login",style: titleStyle.copyWith(color: Colors.white),)),

                    SizedBox(height: 10,),

                    TextButton(onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp_Page()));
                    }, child: Text("First Time? - Create Account",style: titleStyle,))
                  ],
                ),
          ),
            ),
        ),
      ),
    ));
  }
  Future<void> login() async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: _email.text.trim(), password: _pass.text.trim());
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
      ScaffoldMessenger.of(context).showSnackBar(_snakbar());
      // Navigate to the home screen or perform any other necessary action on successful login.
    } catch (e) {
      // Handle login errors here.
      print('Error logging in: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}")));
    }
  }
_snakbar(){
    return SnackBar(content:
     Text("Login Successfully"),
      backgroundColor: Colors.green,
    );
}
// Future<void> login() async {
  //   final auth = FirebaseAuth.instance;
  //   auth.signInWithEmailAndPassword(email: _email.text, password: _pass.text);
  // }
}
