import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Content.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class ActivityPage extends StatefulWidget {
  bool IsProfessor;
  Turma turma;

  ActivityPage(this.IsProfessor, this.turma);

  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  bool get IsProfessor => widget.IsProfessor;

  Turma get turma => widget.turma;
  Pessoa professor;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthController().get_user(turma.Professor),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          professor = Pessoa.fromJson(snapshot.data.data());
          return Container(
            child: Column(
              children: [_addContent(), _ContentListview()],
            ),
          );
        });
  }

  _addContent() {
    if (IsProfessor) {
      return Container(
        padding: EdgeInsets.all(8),
        color: Colors_myclass.black,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () =>
              Nav.pushname(context, "/add-activity", arguments: turma),
          textColor: Colors.grey,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
              side: BorderSide(color: Colors.white)),
          child: Container(
            width: 250,
            height: 50,
            alignment: Alignment.center,
            child: Text(
              "Adicionar uma atividade",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  _ContentListview() {
    return Container(
        height: IsProfessor
            ? MediaQuery.of(context).size.height - 200
            : MediaQuery.of(context).size.height - 150,
        child: StreamBuilder(
            stream: turma.id.collection("Activity").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final atividades = snapshot.data.docs;

              return ListView.builder(
                  itemCount: atividades.length,
                  itemBuilder: (context, index) {
                    Activity atividade =
                        Activity.fromJson(atividades[index].data());
                    return Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors_myclass.black,
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
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
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Utils.spaceSmallHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 8,
                                  ),
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(professor.UrlFoto),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Text(
                                      professor.nome,
                                      style: TextStyle(
                                          color: Colors_myclass.white,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Utils.spaceSmallHeight,
                          Container(
                            padding: EdgeInsets.only(left: 16),
                            child: Text("Prazo: ${atividade.prazo_dia}",
                                style: TextStyle(color: Colors_myclass.white,fontStyle: FontStyle.italic)),
                          ),
                          Utils.spaceSmallHeight,
                          Container(
                            decoration: BoxDecoration(
                                color: Colors_myclass.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16))),
                            padding: EdgeInsets.all(16),
                            alignment: Alignment.topLeft,
                            height: 220,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  atividade.titulo,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Utils.spaceBigHeight,
                                Text(
                                  atividade.orientacao,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton(
                                    onPressed: () {
                                      Nav.pushname(context, "/detail-activity",arguments: [IsProfessor,atividade,turma]);
                                    },
                                    child: Text(
                                      "Ver mais >>",
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }));
  }
}
