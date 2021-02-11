import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/models/Activity.dart';
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
  Turma turma;
  List<Activity> atividades;
  List<Aluno> alunos;
  Pessoa user;
  DocumentReference id_user;

  TurmaPage(this.turma,this.atividades, this.alunos, this.user,this.id_user);

  @override
  _TurmaPageState createState() => _TurmaPageState();
}

class _TurmaPageState extends State<TurmaPage> {
  Turma get turma => widget.turma;
  List<Aluno> get alunos => widget.alunos;
  List<Activity> get atividades => widget.atividades;
  Pessoa get user => widget.user;
  DocumentReference get id_user => widget.id_user;

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


                      if (user.email == turma.Professor.email) {
                        //Se for professor
                        Nav.push(context, ProfessorNotasAlunos(turma, atividades, alunos));

                      } else {
                        //Se for aluno
                        Aluno aluno = alunos.where((element) => element.info.email == user.email).first;
                        Nav.push(context,NotasAluno(turma,atividades, aluno));

                      }
                    }else{
                      //Listar as informações da turma
                      Nav.push(context, InfoTurma(turma));
                    }
                  },
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                      value: "Pessoa",
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
              ContentPage(user, turma),
              ActivityPage(user, turma, alunos),
              ChatPage(user, alunos, turma),
            ],
          )
      ),
    );
  }
}
