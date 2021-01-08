import 'package:flutter/material.dart';
import 'package:myclass/ActivityPage.dart';
import 'package:myclass/ChatPage.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/ContentPage.dart';

class TurmaPage extends StatefulWidget {
  @override
  _TurmaPageState createState() => _TurmaPageState();
}

class _TurmaPageState extends State<TurmaPage> {



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            title: Text(
              "Nome da turma",
              style: TextStyle(color: Colors.white),
            ),
            bottom: TabBar(
              tabs: [Tab(child: Text("Geral",style: TextStyle(color: Colors.white))),
                Tab( child: Text("Atividade",style: TextStyle(color: Colors.white)) ),
                Tab(child: Text("Bate-papo",style: TextStyle(color: Colors.white))),],
            ),
          ),
          body: TabBarView(
            children: [
              ContentPage(true),
              ActivityPage(true),
              ChatPage(true),
            ],
          ),
        ),);
  }
}
