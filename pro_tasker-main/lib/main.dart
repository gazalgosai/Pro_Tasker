//Shree Ganeshay Namah🙏
//Om Namah Shivay

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pro_tasker/db/db_helper.dart';
import 'package:pro_tasker/services/theme_services.dart';
import 'package:pro_tasker/ui/home_page.dart';
import 'package:pro_tasker/ui/main_home_page.dart';
import 'package:pro_tasker/ui/sub_ui/login.dart';
import 'package:pro_tasker/ui/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Test(),
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,

    )
  );
}
//for slapsh screen
class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                MyApp()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:
        // FlutterLogo(size:MediaQuery.of(context).size.height)
        Image(image: AssetImage("images/PRO TASKER.gif"),)


    );
  }
}

//main class
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
        //if user login then goto home screen else login screen
        StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data != null) {
              return Home();
            } else {
              return Login_Page();
            }
          },
        )
    );
  }
}

