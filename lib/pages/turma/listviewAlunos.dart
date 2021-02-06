import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/nav.dart';

class ListAlunos extends StatefulWidget {
  Activity atividade;
  final alunos;

  ListAlunos(this.atividade, this.alunos);

  @override
  _ListAlunosState createState() => _ListAlunosState();
}

class _ListAlunosState extends State<ListAlunos> {
  get atividade => widget.atividade;

  QuerySnapshot get alunos => widget.alunos;


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
        body: ListView.builder(
            itemCount: alunos.docs.length,
            itemBuilder: (context, index) {
              final info = alunos.docs[index].data();
              Aluno aluno = Aluno.fromJson({"atividades":info});
              List<dynamic> links =
                  aluno.atividades["${atividade.titulo}_links"];

              return FutureBuilder(
                  future: info["aluno"].get(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }

                    final data = snapshot.data.data();
                    Pessoa info_aluno = Pessoa.fromJson(data);
                    aluno.info = info_aluno;
                    return Container(
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: Colors_myclass.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  aluno.info.UrlFoto == ""
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(100))),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                            size: 50.0,
                                          ),
                                        )
                                      : CircleAvatar(
                                          backgroundImage:
                                              NetworkImage(aluno.info.UrlFoto),
                                        ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Container(
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          aluno.info.nome,
                                          style: TextStyle(
                                            color: Colors_myclass.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                        ),
                                        Text(
                                          aluno.info.email,
                                          style: TextStyle(
                                            color: Colors_myclass.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    aluno.atividades["${atividade.titulo}_nota"] == ""
                                        ? "Nota: "
                                        : "Nota: ${aluno.atividades["${atividade.titulo}_nota"]}/10",
                                    style: TextStyle(
                                      color: Colors_myclass.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Utils.spaceMediumHeight,
                            Wrap(
                              children: links
                                  .map((e) => Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 4),
                                        margin:
                                            EdgeInsets.symmetric(vertical: 4),
                                        width: 300,
                                        decoration: BoxDecoration(
                                            color: Colors_myclass.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8))),
                                        child: Text(e),
                                      ))
                                  .toList(),
                            ),
                            Utils.spaceMediumHeight,
                            Buttons_myclass.Button1(context,
                                text: "Dar nota",
                                function: () {
                              _showAlertDialog();
                                },
                                colorbackground: Colors_myclass.white,
                                textcolor: Colors_myclass.black),
                            Utils.spaceMediumHeight
                          ],
                        ));
                  });
            }));
  }

  _showAlertDialog() {
    final _formKeyLink = GlobalKey<FormState>();
    String nota = "";
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            "Digite a nota do aluno",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Form(
            key: _formKeyLink,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    decoration: InputDecoration(
                        hintText: "Insira nota",
                        hintStyle: TextStyle(
                          fontSize: 18,
                        ),
                        labelText: "Nota",
                        labelStyle: TextStyle(fontSize: 18, color: Colors.black)),
                    onSaved: (String value) {
                      nota = value;
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                    child: Text(
                  "/"
                )
                ),
                Expanded(
                  flex: 1,
                    child: Text(
                    "10"
                )
                ),
              ],
            )
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                _formKeyLink.currentState.save();
                await AlunoController().set_nota(alunos.docs.first.reference, atividade.titulo, nota);
                Nav.pop(context);
              },
              child: Text("Dar nota"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }
}
