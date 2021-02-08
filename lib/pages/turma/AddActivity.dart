import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  final _formKey = GlobalKey<FormState>();
  Turma turma;
  String titulo;
  String orientacao;
  String prazo_dia;
  String prazo_hora;
  List<String> links = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Nome da turma",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _formAddActivity(),
    );
    ;
  }

  _formAddActivity() {
    turma = Nav.getRouteArgs(context);
    return Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Utils.Text_input(
                hintmensage: "Insira o título da atividade",
                labelmensage: "Título *",
                maxLength: 45,
                onsaved: (value) => titulo = value,
              ),
              Utils.Text_input(
                hintmensage: "Insira a orientação da atividade",
                labelmensage: "Orientação *",
                key_type: TextInputType.multiline,
                onsaved: (value) => orientacao = value,
              ),
              Utils.spaceMediumHeight,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 60,
                    child: Container(
                      child: TextFormField(
                        onSaved: (value) => prazo_dia = value,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          hintText: "dd/mm/aaaa",
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
                          labelText: "Prazo",
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: 60,
                    child: Container(
                      child: TextFormField(
                        onSaved: (value) => prazo_hora = value,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          hintText: "horario hh:mm",
                          hintStyle: TextStyle(
                            fontSize: 20,
                          ),
                          labelText: "Horário",
                          labelStyle:
                              TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Utils.spaceBigHeight,
              Wrap(
                children: links.map((value) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      links.remove(value);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      color: Colors_myclass.black,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Colors_myclass.white,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.delete, color: Colors.white),
                          Spacer(),
                          Icon(Icons.delete, color: Colors.white),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                alignment: WrapAlignment.center,
              ),
              Container(
                width: 75,
                height: 50,
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    "Adicionar link",
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    _showAlertDialog();
                  },
                ),
              ),
              Utils.spaceBigHeight,
              Buttons_myclass.Button1(context, colorbackground: Colors_myclass.black,
                  text: "Adicionar atividade", function: () {
                    _formKey.currentState.save();
                    ActivityController atividade = ActivityController(turma.id.collection("Activity"));
                    atividade.add_activity(titulo, orientacao, links,prazo_dia,prazo_hora);

                    atividade.addActivitiestoAlunos(turma.id.collection("Alunos"),titulo);
                    Nav.pop(context);
                  })
            ],
          ),
        ));
  }

  _showAlertDialog() {
    final _formKeyLink = GlobalKey<FormState>();
    String link = "";
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            "Digite link que queira anexar",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Form(
            key: _formKeyLink,
            child: TextFormField(
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                  hintText: "Insira link para anexar",
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  labelText: "Link",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.black)),
              onSaved: (String value) {
                link = value;
              },
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                _formKeyLink.currentState.save();
                setState(() {
                  links.add(link);
                  print(links);
                });

                Nav.pop(context);
              },
              child: Text("Adicionar"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }
}
