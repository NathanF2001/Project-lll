import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/turma/listviewAlunos.dart';

class DetailActivityPage extends StatefulWidget {
  @override
  _DetailActivityPageState createState() => _DetailActivityPageState();
}

class _DetailActivityPageState extends State<DetailActivityPage> {
  Turma turma;
  Activity atividade;
  bool send;
  List<Aluno> alunos;

  @override
  Widget build(BuildContext context) {
    List values = Nav.getRouteArgs(context);
    atividade = values[0];
    turma = values[1];
    alunos = values[2];

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          atividade.titulo,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildActivityInfo(context),
    );
  }

  _buildActivityInfo(context) {
    return _WidgetDetail(atividade.enviados);
  }


  _WidgetDetail(int done) {

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Prazo: ${atividade.prazo_dia}",
                  style: TextStyle(color: Colors.grey[600]),
                ),
                Text(
                  atividade.prazo_hora,
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
            Utils.spaceBigHeight,
            Text(
              atividade.orientacao,
              textAlign: TextAlign.justify,
              style: TextStyle(color: Colors.grey[800], fontSize: 24),
            ),
            Utils.spaceMediumHeight,
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Atividade enviadas: ${done}/${turma.number_Aluno}",
                  style: TextStyle(fontSize: 26),
                )
            ),
            Utils.spaceMediumHeight,
            Wrap(children: atividade.anexo.map((e) {
              return Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                alignment: Alignment.center,
                child: Text(e, overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              );
            }).toList(),),

            Utils.spaceMediumHeight,
            Buttons_myclass.Button1(
                context, colorbackground: Colors_myclass.black,
                text: "Ver atividades dos alunos",
                function: () {
                  final map_aluno = {};
                  print(alunos);
                  alunos.forEach((e) {
                    print(e.atividades);
                    map_aluno[e.atividades["aluno"].id]= e.info;
                  });

                  Nav.push(context, ListAlunos(atividade,map_aluno,turma));
                },
                fontsize: 20.0),
          ],
        )
      ),
    );
  }
}
