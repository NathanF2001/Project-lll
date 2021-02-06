import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/models/Content.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class ContentPage extends StatefulWidget {
  DocumentReference user;
  DocumentReference professor;
  Turma turma;

  ContentPage(this.user, this.turma,this.professor);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  DocumentReference get user => widget.user;
  DocumentReference get prof => widget.professor;

  Turma get turma => widget.turma;

  bool IsProfessor;
  Pessoa professor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    IsProfessor = user.id == prof.id;
    professor = turma.Professor;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: [_addContent(), _ContentListview()],
      ),
    );
  }

  _addContent() {
    if (IsProfessor) {
      return Container(
        padding: EdgeInsets.all(8),
        color: Colors_myclass.black,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () =>
              Nav.pushname(context, "/add-content", arguments: turma),
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
              "Adicionar um conteúdo",
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
            stream: turma.id.collection("Content").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final conteudos = snapshot.data.docs;

              return ListView.builder(
                  itemCount: conteudos.length,
                  itemBuilder: (context, index) {
                    Content conteudo =
                        Content.fromJson(conteudos[index].data());
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
                        children: [
                          Utils.spaceSmallHeight,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(professor.UrlFoto),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      professor.nome,
                                      style: TextStyle(
                                          color: Colors_myclass.white,
                                          fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(conteudo.data,
                                      style: TextStyle(
                                          color: Colors_myclass.white))
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            child: Container(
                              height: 10,
                            ),
                          ),
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
                                  conteudo.titulo,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Utils.spaceBigHeight,
                                Text(
                                  conteudo.orientacao,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton(
                                    onPressed: () async {
                                      await AlunoController().getAllAlunos(turma.id);
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
