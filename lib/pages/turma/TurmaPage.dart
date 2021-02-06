import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/models/Alunos.dart';
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
  DocumentReference id_user;
  DocumentReference id_professor;
  Turma turma;
  List<Future<Aluno>> alunos;



  @override
  Widget build(BuildContext context) {
    List<dynamic> values = Nav.getRouteArgs(context);
    id_user = values[0];
    turma = values[1];
    id_professor = values[2];
    alunos = values[3];

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
              ContentPage(id_user,turma,id_professor),
              ActivityPage(id_user,turma,id_professor),
              ChatPage(id_user,id_professor,alunos,turma),
            ],
          ),
        ),);
  }
}
