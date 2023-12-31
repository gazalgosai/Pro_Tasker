import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const PrimaryClr = bluishClr;
const Color light_purple = Color(0xffc590ff);
const Color mint = Color(0xffa9ffb5);
const Color butter = Color(0xfffcffb9);
const Color darkGreyClr = Color(0xFF121212);
Color darkHeaderClr = Color(0xFF424242);



class Themes{

  static final light =  ThemeData(
    backgroundColor: Colors.white,
  primaryColor: PrimaryClr,
  brightness: Brightness.light,
 useMaterial3: true,
  );

  static final dark =  ThemeData(
    backgroundColor: darkGreyClr,
  primaryColor: darkGreyClr,
  brightness: Brightness.dark,
   useMaterial3: true,
  );
}

TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 24,
          fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
      ),
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[100]: Colors.grey[600],
    ),
  );
}