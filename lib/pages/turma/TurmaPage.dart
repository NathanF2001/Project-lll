import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/turma/Atividade/ActivityPage.dart';
import 'package:myclass/pages/turma/Chat/ChatPage.dart';
import 'package:myclass/pages/turma/Content/ContentPage.dart';

import 'package:myclass/pages/turma/InfoTurma.dart';
import 'package:myclass/pages/turma/ListPessoa.dart';
import 'package:myclass/pages/turma/NotaAluno.dart';
import 'package:myclass/pages/turma/ProfessorNotasAlunos.dart';

class TurmaPage extends StatefulWidget {
  @override
  _TurmaPageState createState() => _TurmaPageState();
}

class _TurmaPageState extends State<TurmaPage> {
  DocumentReference id_user;
  DocumentReference id_professor;
  Turma turma;
  List<Aluno> alunos;
  Pessoa user;

  @override
  Widget build(BuildContext context) {
    List<dynamic> values = Nav.getRouteArgs(context);
    id_user = values[0];
    turma = values[1];
    id_professor = values[2];
    alunos = values[3];
    user = values[4];

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
              tabs: [
                Tab(child: Text(
                    "Geral", style: TextStyle(color: Colors.white))),
                Tab(
                    child:
                    Text("Atividade", style: TextStyle(color: Colors.white))),
                Tab(
                    child:
                    Text("Bate-papo", style: TextStyle(color: Colors.white))),
              ],
            ),
            actions: [
              Container(
                padding: EdgeInsets.all(8),
                child: PopupMenuButton(
                  onSelected: (value) async{
                    if (value == "Pessoa"){
                      // Listar todos os alunos da turma
                      Nav.push(context, ListPessoa(alunos, turma));
                    }else if (value == "Notas"){
                      // Pegar todas as atividades
                      ActivityController controller = ActivityController(turma.id.collection("Activity"));
                      List<QueryDocumentSnapshot> atividades = await controller.getAllActivities();

                      if (id_professor == id_user) {
                        //Se for professor
                        Nav.push(context, ProfessorNotasAlunos(turma, atividades, alunos));

                      } else {
                        //Se for aluno
                        Aluno aluno = await AlunoController().fromJson(turma.id, id_user, user);
                        Nav.push(context,NotasAluno(turma, atividades, aluno));

                      }
                    }else{
                      //Listar as informações da turma
                      Nav.push(context, InfoTurma(turma));
                    }
                  },
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                      value: "Pessoas",
                        child: Text("Pessoas")),
                    PopupMenuItem(
                      value: "Notas",
                        child: Text("Notas")),
                    PopupMenuItem(
                      value: "Info Turma",
                        child: Text("Info Turma"))
                  ],
                  child: Icon(Icons.more_vert),
                ),
              )
            ],
          ),
          body: TabBarView(
            children: [
              ContentPage(id_user, turma, id_professor),
              ActivityPage(id_user, turma, id_professor, alunos),
              ChatPage(id_user, id_professor, alunos, turma),
            ],
          )
      ),
    );
  }
}
