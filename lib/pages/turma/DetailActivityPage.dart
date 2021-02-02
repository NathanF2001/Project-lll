import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class DetailActivityPage extends StatefulWidget {
  @override
  _DetailActivityPageState createState() => _DetailActivityPageState();
}

class _DetailActivityPageState extends State<DetailActivityPage> {
  bool Isprofessor;
  Turma turma;
  Activity atividade;

  @override
  Widget build(BuildContext context) {
    List values = Nav.getRouteArgs(context);
    Isprofessor = values[0];
    atividade = values[1];
    turma = values[2];

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

    return SingleChildScrollView(
        child: Container(
      height: MediaQuery.of(context).size.height,
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
            child: Isprofessor
                ? Text(
              "Atividade enviadas 15/40",
              style: TextStyle(fontSize: 26),
            )
                : Text(
              "Status: pendente",
              style: TextStyle(fontSize: 26),
            ),
          ),
          Utils.spaceMediumHeight,
          Wrap(children: atividade.anexo.map((e) {
            return Container(
              width: MediaQuery.of(context).size.width,
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
          Isprofessor
              ? Buttons_myclass.Button1(context, colorbackground: Colors_myclass.black,
                  text: "Ver atividades dos alunos",
                  function: () {},
                  fontsize: 20.0)
              : Column(
                  children: [
                    Buttons_myclass.Button1(context,
                        text: "Adicionar resposta",
                        function: () {},
                        colorbackground: Color(0xBB13CE66)),
                    Utils.spaceSmallHeight,
                    Buttons_myclass.Button1(context, colorbackground: Colors_myclass.black,
                        text: "Enviar", function: () {})
                  ],
                )
        ],
      ),
    ));
  }
}
