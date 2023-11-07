import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pro_tasker/ui/sub_ui/login.dart';
import '../main_home_page.dart';
import '../theme.dart';

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({Key? key}) : super(key: key);

  @override
  State<SignUp_Page> createState() => _SignUp_PageState();
}

class _SignUp_PageState extends State<SignUp_Page> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _pass= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Center
        (
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //images
                  Image(image: AssetImage("images/signup.webp"),height: 250),

                  SizedBox(height: 15,),

                  //heading
                  Text("Create Account",style: headingStyle,),

                  //sub-heading
                  Text("Create a new Account",style: titleStyle,),

                  SizedBox(height: 15,),
                  //email
                  TextFormField(
                    controller: _email,
                    textInputAction: TextInputAction.done,
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

                  //username
                  TextFormField(
                    controller: _name,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please Enter Username";
                      }
                      return null;
                    },
                    decoration:InputDecoration(
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(5), ),
                      prefixIcon: Icon(Icons.person),
                      hintText: "Username",
                    ),
                  ),


                  SizedBox(height: 15,),

                  //age
                  TextFormField(
                    controller: _age,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if(value!.isEmpty ){
                        return "Please Enter 18+ Age";
                      }
                      return null;
                    },
                    decoration:InputDecoration(
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(5), ),
                      prefixIcon: Icon(Icons.panorama_fish_eye),
                      hintText: "Age",
                    ),
                  ),


                  SizedBox(height: 15,),

                  //phone
                  TextFormField(
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if(value!.isEmpty || value!.length != 10){
                        return "Please Enter Mobile-Number";
                      }
                      return null;
                    },
                    decoration:InputDecoration(
                      border:OutlineInputBorder(borderRadius:BorderRadius.circular(5), ),
                      prefixIcon: Icon(Icons.send_to_mobile_outlined),
                      hintText: "Mobile-Number",
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
                          signup();
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
                      child: Text("Create Account",style: titleStyle.copyWith(color: Colors.white),)),

                  SizedBox(height: 10,),

                  TextButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login_Page()));
                  }, child: Text("Have an Account? - Login",style: titleStyle,))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  //sign up by firebase
  Future<void> signup() async {
    final auth = FirebaseAuth.instance;
    try {
      await auth.createUserWithEmailAndPassword(email: _email.text.trim(), password: _pass.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Create Account Successfully"),backgroundColor: Colors.green,));

      Navigator.push(context, MaterialPageRoute(builder: (context) => Home(),));
      // Navigate to the home screen or perform any other necessary action on successful signup.
    } catch (e) {
      // Handle signup errors here.
      print('Error signing up: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${e.toString()}"),backgroundColor: Colors.red,));
    }
  }


}
