
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: InkWell(
          onTap: (){},
          child: Icon(Icons.dehaze_rounded),
        ),
        title: Text("MyClass",style: TextStyle(color: Colors.white),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors_myclass.main_color,

        child: Icon(Icons.add),
      ),
    );
  }
}
