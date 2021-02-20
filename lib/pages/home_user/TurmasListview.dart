import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/controller/TurmaController.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';

import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/TurmasTemplate.dart';
import 'package:myclass/pages/turma/TurmaPage.dart';

class TurmasListView extends StatefulWidget {
  Pessoa user;
  DocumentReference id_user;
  String search_string;
  String link_webservice;

  TurmasListView(this.user, this.id_user, this.search_string,this.link_webservice);


  @override
  _TurmasListViewState createState() => _TurmasListViewState();
}

class _TurmasListViewState extends State<TurmasListView> {
  Pessoa get user => widget.user;
  String get search_string => widget.search_string;
  DocumentReference get id_user => widget.id_user;

  @override
  Widget build(BuildContext context) {
    return user.Turmas_reference.isEmpty ? Container() :
    StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Turmas")
            .where("codigo", whereIn: user.Turmas_reference)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          // Enquanto não encontra os dados
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
            ),
            );
          }

          // Caso ocorra algum erro
          if (snapshot.hasError) {
            return Center(
              child: Text("Deu algum erro"),
            );
          }

          List<QueryDocumentSnapshot> turmas_snapshot = snapshot.data.docs;


          return ListView.builder(
                shrinkWrap: true,
                itemCount: turmas_snapshot.length,
                itemBuilder: (context, index){

                  Map<String,dynamic> json_turma = turmas_snapshot[index].data();

                  if (json_turma["Nome"].contains(search_string)){
                    return _buildTurmainfo(json_turma);
                  }
                  else{
                    return Container();
                  }
                });
          }
        );
  }

  Widget _buildTurmainfo(json_turma) {
    return FutureBuilder(
        future: json_turma["Professor"].get(),
        builder: (context, snapshot_future) {

          if (!snapshot_future.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          Turma turma  = TurmaController().fromJson(json_turma, snapshot_future.data.data());

          return Container(
              margin: EdgeInsets.all(8),
              decoration: (BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.circular(16.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      5.0, // Move to right 10  horizontally
                      2.0, // Move to bottom 5 Vertically
                    ),
                  )
                ],
              )),
              child: InkWell(
                child: TurmasTemplate(turma),
                onTap: () async {

                  DocumentReference ref_turma = await TurmaController().get_turmabycode(turma.codigo).then((value) => value.reference);

                  ActivityController controller = ActivityController(ref_turma.collection("Activity"));
                  List<QueryDocumentSnapshot> atividades = await controller.getAllActivities();
                  List<Activity> atvs = await controller.fromJsonList(atividades);

                  List<Aluno> alunos = await AlunoController().getAllAlunos(ref_turma,atvs);


                  turma.id = ref_turma;
                  Nav.push(context, TurmaPage(turma,atvs, alunos, user,id_user,widget.link_webservice));
                },
              ));
        });
  }
}
