import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/turma/ActivityPage.dart';
import 'package:myclass/pages/turma/ChatPage.dart';
import 'package:myclass/pages/turma/ContentPage.dart';



class TurmaPage extends StatefulWidget {
  @override
  _TurmaPageState createState() => _TurmaPageState();
}

class _TurmaPageState extends State<TurmaPage> {
  String id_Professor;
  Turma turma;
  Pessoa professor;



  @override
  Widget build(BuildContext context) {
    List<dynamic> values = Nav.getRouteArgs(context);
    id_Professor = values[0];
    turma = values[1];
    bool IsProfessor = id_Professor == turma.Professor;

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            title: Text(
              turma.Nome,
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
              ContentPage(IsProfessor,turma),
              ActivityPage(IsProfessor,turma),
              ChatPage(IsProfessor),
            ],
          ),
        ),);
  }
}
