import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/models/Content.dart';
import 'package:myclass/models/Turma.dart';

class ContentDetail extends StatelessWidget {
  Turma turma;
  Content conteudo;

  ContentDetail(this.turma, this.conteudo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          turma.Nome,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _buildDetail(context),
    );
  }

  _buildDetail(context) {
    return ListView(
      children: [
        Container(

          color: Colors_myclass.black,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(16),
          child: Text(
            conteudo.titulo,
            style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,color: Colors_myclass.white),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            "Data enviada: ${conteudo.data}",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Text(
            conteudo.orientacao,
            style: TextStyle(fontSize: 24),
          ),
        ),
        Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors_myclass.black
          ),
          child: Text("Links",
          style: TextStyle(fontSize: 24,color: Colors_myclass.white),),
        ),
        Container(
          child: Wrap(
            children: conteudo.anexo.map((element) =>
                Container(
                  decoration: BoxDecoration(

                  ),
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 2),
                  padding: EdgeInsets.all(16),
              child: Text(
                element,
                style: TextStyle(color: Colors.grey,decoration: TextDecoration.underline),
              ),
            )).toList(),
          ),
        ),
        Utils.spaceBigHeight
      ],
    );
  }
}
