import 'package:flutter/material.dart';

class Global{
  static const  kCardTextColor = TextStyle(color: Colors.white);

  void scrollToTopInstantly (ScrollController controller){
    controller.animateTo(0, duration: const Duration(microseconds: 1), curve: Curves.linear);
  }

  static const Color colorProPakistani = Color.fromRGBO(29, 122, 116, 1.0);
  static const Color colorDawn = Color.fromRGBO(27, 37, 46, 1.0);

  static const Color kColorPrimary = Color.fromRGBO(29, 122, 116, 1.0);

  static const Color colorDarkMode = Color.fromARGB(255, 20, 33, 37);

  

  static BoxShadow kFabShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 5,
    offset: const Offset(0, 0), // changes the position of the shadow
  );

  
}
