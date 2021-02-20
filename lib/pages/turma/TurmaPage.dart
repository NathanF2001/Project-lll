import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Utils.dart';
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
import 'package:myclass/pages/turma/CreateGrupos.dart';

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
  String link_webservice;

  TurmaPage(this.turma, this.atividades, this.alunos, this.user, this.id_user,this.link_webservice);

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
        child: Utils().Scaffold_myclass(
          title: turma.Nome,
          body: TabBarView(
            children: [
              ContentPage(user, turma),
              ActivityPage(user, turma, alunos),
              ChatPage(user, alunos, turma),
            ],
          ),
          bottom_appbar: TabBar(
            tabs: [
              Tab(child: Text("Geral", style: TextStyle(color: Colors.white))),
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
                onSelected: (value) async {
                  if (value == "Pessoa") {
                    // Listar todos os alunos da turma
                    Nav.push(context, ListPessoa(alunos, turma));
                  } else if (value == "Notas") {
                    // Pegar todas as atividades

                    if (user.email == turma.Professor.email) {
                      //Se for professor
                      Nav.push(context,
                          ProfessorNotasAlunos(turma, atividades, alunos));
                    } else {
                      //Se for aluno
                      Aluno aluno = alunos
                          .where((element) => element.info.email == user.email)
                          .first;
                      Nav.push(context, NotasAluno(turma, atividades, aluno));
                    }
                  } else if (value == "Info Turma") {
                    //Listar as informações da turma
                    Nav.push(context, InfoTurma(turma, user, alunos));
                  } else {
                    bool aluno_incompleto = alunos.any((element) => element.info.classificacao == null);
                    if (aluno_incompleto){
                      Utils().statusAlertDialog(context, "Não é possível classificar", "Alunos sem classificação");
                    }else {
                      String status = await Nav.push(context, CreateGrupos(turma, alunos,widget.link_webservice));
                      if (status == "ok"){
                        Utils().statusAlertDialog(context, "Sucesso", "Grupos criados com sucesso");
                      }

                    }
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: "Pessoa", child: Text("Pessoas")),
                  PopupMenuItem(value: "Notas", child: Text("Notas")),
                  PopupMenuItem(value: "Info Turma", child: Text("Info Turma")),
                  PopupMenuItem(value: "Criar grupos", child: Text("Criar grupos"),enabled: turma.Professor.email == user.email ,)
                ],
                child: Icon(Icons.more_vert),
              ),
            )
          ],
        ));
  }
}
