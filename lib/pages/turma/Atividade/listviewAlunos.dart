import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/models/Activity.dart';
import 'package:myclass/models/ActivityAluno.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class ListAlunos extends StatefulWidget {
  Activity atividade;
  List<Aluno> alunos;
  Turma turma;

  ListAlunos(this.atividade, this.alunos, this.turma);

  @override
  _ListAlunosState createState() => _ListAlunosState();
}

class _ListAlunosState extends State<ListAlunos> {
  Activity get atividade => widget.atividade;

  List<Aluno> get alunos => widget.alunos;

  Turma get turma => widget.turma;

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
            itemCount: alunos.length,
            itemBuilder: (context, index) {
              final aluno = alunos[index];
              ActivityAluno atividade_aluno =
                  aluno.atividades[atividade.titulo];

              print(atividade_aluno.links);
              List<dynamic> links = atividade_aluno.links;


              return Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors_myclass.black,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          atividade_aluno.nota == ""
                              ? "Nota: Não definido"
                              : "Nota: ${atividade_aluno.nota}/10",
                          style: TextStyle(
                            color: Colors_myclass.white,
                          ),
                        ),
                      ),
                      Utils.spaceMediumHeight,
                      Wrap(
                        children: links
                            .map((e) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 4),
                                  margin: EdgeInsets.symmetric(vertical: 4),
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: Colors_myclass.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Text(e),
                                ))
                            .toList(),
                      ),
                      Utils.spaceMediumHeight,
                      Buttons_myclass.Button1(context, text: "Dar nota",
                          function: () {
                        _showAlertDialog(index);
                      },
                          colorbackground: Colors_myclass.white,
                          textcolor: Colors_myclass.black),
                      Utils.spaceMediumHeight
                    ],
                  ));
            }));
  }

  _showAlertDialog(index) {
    Aluno aluno = alunos[index];
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
                          labelStyle:
                              TextStyle(fontSize: 18, color: Colors.black)),
                      onSaved: (String value) {
                        nota = value;
                      },
                    ),
                  ),
                  Expanded(flex: 1, child: Text("/")),
                  Expanded(flex: 1, child: Text("10")),
                ],
              )),
          actions: [
            FlatButton(
              onPressed: () async {
                _formKeyLink.currentState.save();
                // Mudar o valor da nota
                await AlunoController().set_nota(turma.id,
                    aluno.atividades["aluno"], atividade.titulo, nota);

                alunos[index].atividades[atividade.titulo].nota = nota;
                print(alunos[index].atividades[atividade.titulo].nota);

                setState(() {

                });
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
