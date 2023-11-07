import 'package:flutter/material.dart';

import '../theme.dart';

//button widget
class MyButton extends StatelessWidget {
  final String lable;
  final Function onTap;
  const MyButton({Key? key,required this.lable,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onTap,
       child: Container(
         alignment: Alignment.center,
         width: 120,
         height: 60,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(20),
           color: PrimaryClr
         ),
         child: Text(
           lable,
           style: TextStyle(
             color: Colors.white,
           ),
         ),
       ),
    );
  }
}
