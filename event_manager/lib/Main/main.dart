import 'package:event_manager/Main/MainActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}

void main() async{

  runApp(
    MaterialApp(
      title: "Event Planner",
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
//        primaryColor: Colors.pink[100],
//        primaryColor: Colors.pinkAccent[100],
        primaryColor: hexToColor('#288899'),
        accentColor: Colors.blue,
//        primaryColorLight: Colors.pink.shade50,
        primaryColorLight: Colors.white,
        buttonColor: Colors.grey,
        // Define the default font family.
        fontFamily: 'Montserrat',
        bottomAppBarColor: hexToColor('#a84f36') ,

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Eng'),
      ),
      ),
      home: MainActivity(),
  ),
  );
}


