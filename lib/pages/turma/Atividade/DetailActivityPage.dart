import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/turma/Atividade/listviewAlunos.dart';


class DetailActivityPage extends StatefulWidget {
  Activity atividade;
  Turma turma;
  List<Aluno> alunos;


  DetailActivityPage(this.atividade, this.turma, this.alunos);

  @override
  _DetailActivityPageState createState() => _DetailActivityPageState();
}

class _DetailActivityPageState extends State<DetailActivityPage> {
  Turma get turma => widget.turma;
  Activity get atividade => widget.atividade;
  List<Aluno> get alunos => widget.alunos;

  @override
  Widget build(BuildContext context) {

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


                  Nav.push(context, ListAlunos(atividade,alunos,turma));
                },
                fontsize: 20.0),
          ],
        )
      ),
    );
  }
}
