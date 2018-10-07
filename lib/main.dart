import 'package:flutter/material.dart';
import './ui/SplashScreen.dart';


void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title:"BMI Calculator",
    theme: ThemeData(
        fontFamily: 'BebasNeue',
        brightness: Brightness.dark,
        buttonColor: Colors.green[300],
        accentColor: Colors.white,
        scaffoldBackgroundColor: Colors.blueGrey[900],
        canvasColor: Colors.blueGrey[900],
        textSelectionColor: new Color.fromRGBO(81, 107, 84, 0.8),
        bottomAppBarColor: Colors.blueGrey[800],
        primaryColor: Colors.blueGrey[900],
        indicatorColor: Colors.white,
        cardColor: Colors.white,
        highlightColor: Colors.white,
        errorColor: Colors.red[400],
        textSelectionHandleColor: Colors.white,
        splashColor: Colors.white10,
        buttonTheme: new ButtonThemeData(
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(22.0))),
        inputDecorationTheme: new InputDecorationTheme(
            contentPadding:
                new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            border: new OutlineInputBorder(
                gapPadding: 3.0,
                borderRadius: new BorderRadius.circular(22.0))),
      ),
    home: new SplashScreen(),
  ));
}