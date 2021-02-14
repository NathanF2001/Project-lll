import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
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
import 'package:myclass/pages/turma/Atividade/UpdateActivity.dart';
import 'package:myclass/pages/turma/Atividade/listviewAlunos.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailActivityPage extends StatefulWidget {
  Activity atividade;
  Turma turma;
  List<Aluno> alunos;
  DocumentReference ref_activity;

  DetailActivityPage(this.atividade, this.turma, this.alunos,this.ref_activity);

  @override
  _DetailActivityPageState createState() => _DetailActivityPageState();
}

class _DetailActivityPageState extends State<DetailActivityPage> {
  Turma get turma => widget.turma;
  Activity get atividade => widget.atividade;
  List<Aluno> get alunos => widget.alunos;
  DocumentReference get ref_activity => widget.ref_activity;

  set atividade(Activity newvalue){
    widget.atividade = newvalue;
  }
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
            Wrap(children: atividade.anexo.map((element) {
              return Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 60,
                margin: EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                alignment: Alignment.center,
                child: RichText(
                    text: TextSpan(
                        text: element,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        recognizer: TapGestureRecognizer()..onTap = () async{
                          if (await canLaunch(element)){
                            await launch(element);
                          }
                        }
                    )
                )
              );
            }).toList(),),

            Utils.spaceMediumHeight,
            Buttons_myclass.Button1(
                context, colorbackground: Colors_myclass.black,
                text: "Ver atividades dos alunos",
                function: () async {


                  await Nav.push(context, ListAlunos(atividade,alunos,turma,ref_activity));
                },
                fontsize: 20.0),
            Utils.spaceBigHeight,
            Buttons_myclass.Button1(context, text: "Atualizar atividade",colorbackground: Colors_myclass.black,
            function: () async{
              Activity new_atividade = await Nav.push(context, UpdateActivity(turma,atividade));
              if (new_atividade == null){
                return null;
              }

              setState(() {
                atividade = new_atividade;
              });
            })
          ],
        )
      ),
    );
  }
}
