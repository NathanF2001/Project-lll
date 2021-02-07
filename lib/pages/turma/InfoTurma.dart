import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/models/Turma.dart';

class InfoTurma extends StatelessWidget {
  Turma turma;

  InfoTurma(this.turma);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),

        title: Text(
          "Informação da turma",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Utils.spaceBigHeight,
              Container(
                alignment: Alignment.center,
                child: turma.UrlTurma == ""
                    ? Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 150,
                  ),
                )
                    : CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(turma.Professor.UrlFoto),
                ),
              ),
              Utils.spaceMediumHeight,
              Container(
                padding: EdgeInsets.all(16),
                color: Colors_myclass.app_color,
                child: Text(
                  turma.Nome,
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors_myclass.white),
                ),
              ),
              Container(
                color: Colors_myclass.white,
                padding: EdgeInsets.all(16),
                child: Text(
                  turma.Descricao,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors_myclass.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width*0.75,
                      decoration: BoxDecoration(
                        color: Colors_myclass.black,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(32),bottomRight: Radius.circular(32))

                      ),
                      child: Text("Nome professor",
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400,color: Colors_myclass.white),),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                          turma.Professor.nome,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Utils.spaceSmallHeight,
                    Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width*0.75,
                      decoration: BoxDecoration(
                          color: Colors_myclass.black,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(32),bottomRight: Radius.circular(32))

                      ),
                      child: Text("Contato",
                        style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400,color: Colors_myclass.white),),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        turma.Professor.email,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Utils.spaceBigHeight
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
