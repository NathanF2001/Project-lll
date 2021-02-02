import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ContentController.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class AddContent extends StatefulWidget {
  @override
  _AddContentState createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  final _formKey = GlobalKey<FormState>();
  Turma turma;
  String titulo;
  String orientacao;
  List<String> links = [];


  @override
  Widget build(BuildContext context) {
    turma = Nav.getRouteArgs(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          turma.Nome,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _formAddContent(),
    );
  }

  _formAddContent() {
    return Container(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Utils.Text_input(
                      hintmensage: "Insira o título do conteúdo",
                      labelmensage: "Título *",
                      maxLength: 45,
                      onsaved: (value) => titulo = value,
                    ),
                    Utils.Text_input(
                      hintmensage: "Insira o assunto",
                      labelmensage: "Assunto *",
                      key_type: TextInputType.multiline,
                      onsaved: (value) => orientacao = value,
                    ),
                  ],
                ),
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
                      padding: EdgeInsets.only(left: 16,top: 8,bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      color: Colors_myclass.black,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: TextStyle(
                            color: Colors_myclass.white,
                          decoration: TextDecoration.underline
                        ),
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
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                  onTap: () {
                    _showAlertDialog();
                  },
                ),
              ),
              Utils.spaceBigHeight,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Buttons_myclass.Button1(context, text: "Adicionar conteúdo", colorbackground: Colors_myclass.black,function: (){
                  _formKey.currentState.save();
                  ContentController conteudo = ContentController(turma.id.collection("Content"));
                  conteudo.add_content(titulo, orientacao, links);
                  Nav.pop(context);
                }),
              )
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
