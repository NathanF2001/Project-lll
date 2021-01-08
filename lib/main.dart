import 'package:flutter/material.dart';
import 'package:myclass/AddActivity.dart';
import 'package:myclass/AddChat.dart';
import 'package:myclass/AddContent.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/CreateTurma.dart';
import 'package:myclass/LoginPage.dart';
import 'package:myclass/RegisterPage.dart';
import 'package:myclass/TalkPage.dart';
import 'package:myclass/TurmaPage.dart';
import 'package:myclass/UserPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: _buildThemeData(),
    initialRoute: "/",
    routes: _builderRoutes(),);
  }

  ThemeData _buildThemeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors_myclass.app_color,
      fontFamily: "Roboto",
      textTheme: TextTheme(
        headline1: TextStyle(fontSize: 86.0, fontWeight: FontWeight.bold),
        headline2: TextStyle(fontSize: 68.0),
        headline3: TextStyle(fontSize: 54.0),
        headline4: TextStyle(fontSize: 43.0),
        headline5: TextStyle(fontSize: 34.0),
        headline6: TextStyle(fontSize: 27.0),
        bodyText1: TextStyle(fontSize: 20.0),
        bodyText2: TextStyle(fontSize: 18.0),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: UnderlineInputBorder(),
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Color(0xFF13CE61),
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  _builderRoutes() {
    return {
      "/" : (context) => LoginPage(),
      "/register": (context) => RegisterPage(),
      "/home": (context) => UserPage(),
      "/create-turma": (context) => CreateTurma(),
      "/turma-page": (context) => TurmaPage(),
      "/add-content": (context) => AddContent(),
      "/add-activity": (context) => AddActivity(),
      "/add-chat": (context) => AddChat(),
      "mensage-page": (context) => MensagePage(),
    };
  }
}




