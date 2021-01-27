import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/nav.dart';

class DetailActivityPage extends StatelessWidget {
  bool Isprofessor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Nome da atividade",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildActivityInfo(context),
    );
  }

  _buildActivityInfo(context) {
    Isprofessor = Nav.getRouteArgs(context);

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
                "Prazo: dd/mm/aaaa",
                style: TextStyle(color: Colors.grey[600]),
              ),
              Text(
                "23:23",
                style: TextStyle(color: Colors.grey[600]),
              )
            ],
          ),
          Utils.spaceBigHeight,
          Text(
            "Nessa atividade aborda todos os conceitos que abordamos em sala de aula. "
            "Leiam o material de referência da disciplina e respondam e entreguem a atividade",
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.grey[800],fontSize: 24),
          ),
          Utils.spaceMediumHeight,
          Isprofessor ?
              Text("Atividade enviadas 15/40",style: TextStyle(fontSize: 26),) : Text("Status: pendente",style: TextStyle(fontSize: 26),),
          Utils.spaceMediumHeight,
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            alignment: Alignment.center,
            child: Text("Documento da atividade",style: TextStyle(color: Colors.white,fontSize: 24)),
          ),
          Utils.spaceMediumHeight,
          Isprofessor ?
              Buttons_myclass.Button1(context, text: "Ver atividades dos alunos",function: (){},fontsize: 20.0) :
              Column(
                children: [
                  Buttons_myclass.Button1(context, text: "Adicionar resposta",function: (){},colorbackground: Color(0xBB13CE66)),
                  Utils.spaceSmallHeight,
                  Buttons_myclass.Button1(context, text: "Enviar",function: (){})
                ],
              )
        ],
      ),
    ));
  }
}
