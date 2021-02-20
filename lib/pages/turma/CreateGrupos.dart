import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ChatController.dart';
import 'package:myclass/controller/webservice.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class CreateGrupos extends StatefulWidget {
  Turma turma;
  List<Aluno> alunos;
  String link_webservice;

  CreateGrupos(this.turma, this.alunos, this.link_webservice);

  @override
  _CreateGruposState createState() => _CreateGruposState();
}

class _CreateGruposState extends State<CreateGrupos> {
  final _formKey = GlobalKey<FormState>();

  Turma get turma => widget.turma;

  List<Aluno> get alunos => widget.alunos;

  String get link_webservice => widget.link_webservice;

  String max_integrantes;
  String name_chats;

  @override
  Widget build(BuildContext context) {
    return Utils().Scaffold_myclass(
        title: "Criar grupos - Machine Learning", body: _BuildCreateGrupos());
  }

  _BuildCreateGrupos() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Número de alunos na turma: ${turma.number_Aluno}",
                style: TextStyle(fontSize: 24),
              ),
              Utils.spaceBigHeight,
              Utils.Text_input(
                  hintmensage: "Número máximo de alunos",
                  key_type: TextInputType.number,
                  labelmensage: "Máximo integrantes",
                  onsaved: (String value) {
                    max_integrantes = value;
                  },
                  validator: (String value) {
                    if (value == "") {
                      return "Entrada inválida (Vazio)";
                    }
                    if (!_isNumeric(value)) {
                      return "Entrada inválida, (Não numerico)";
                    }
                  }),
              Utils.spaceBigHeight,
              Utils.Text_input(
                  hintmensage: "Insira nome do chats",
                  labelmensage: "Nome dos Chats",
                  onsaved: (value) {
                    name_chats = value;
                  },
                  validator: (value) {
                    if (value == "") {
                      return "Entrada inválida (Vazia)";
                    }
                  }),
              Utils.spaceBigHeight,
              Buttons_myclass.Button1(context, text: "Criar Chats",
                  colorbackground: Colors_myclass.black,
                  function: () async{
                    _formKey.currentState.save();

                    bool validate = _formKey.currentState.validate();
                    if (!validate) {
                      return;
                    }

                     await _showAlertDialog("Confirmar",
                        "Tem certeza que deseja criar grupos de até ${max_integrantes} alunos?");

                  })
            ],
          ),
        ));
  }

  _showAlertDialog(title_text, content_text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title_text,
            style: Theme
                .of(context)
                .textTheme
                .headline5,
          ),
          content: Text(
            content_text,
            style: Theme
                .of(context)
                .textTheme
                .bodyText2,
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                List<List<String>> chats = await WebService().get_chats(max_integrantes, alunos, link_webservice);

                for(var index= 0;index < chats.length;index++){
                  List<String> pessoas = chats[index];
                  pessoas.add(turma.Professor.email);
                  await ChatController().add(turma.id, "${name_chats} ${index + 1}", pessoas);
                }

                Nav..pop(context)..pop(context,result: "ok");
              },
              child: Text("OK"),
              textColor: Colors.black87,
            ),
            FlatButton(
              onPressed: () => Nav.pop(context),
              child: Text("Cancelar"),
              textColor: Colors.black87,
            ),

          ],
        );
      },
    );
  }

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }
}
