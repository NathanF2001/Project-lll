import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ChatController.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';

import '../../../nav.dart';

class AddChat extends StatefulWidget {
  Turma turma;
  List<Aluno> alunos;

  AddChat(this.turma, this.alunos);

  @override
  _AddChatState createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  final _formKey = GlobalKey<FormState>();
  List<Aluno> get alunos => widget.alunos;
  Turma get turma => widget.turma;
  Aluno current_aluno;
  String nomeChat;

  List<Aluno> Wrap_alunos = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          turma != null ? turma.Nome : "",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _formAddChat(),
    );
    ;
  }

  _formAddChat() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Utils.spaceBigHeight,
            Utils.Text_input(
                hintmensage: "Digite nome do Bate-papo",
                labelmensage: "Nome do bate-papo",
                maxLength: 60,
                validator: (String value) {
                  return (value == "") | (value.length > 60) ? "Nome inválido" : null;
                },
            onsaved: (value){
                  nomeChat = value;
            }),
            Utils.spaceBigHeight,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      labelText: 'Alunos*',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                    ),
                    items:
                    alunos.map<DropdownMenuItem<Aluno>>((aluno) {
                      return DropdownMenuItem<Aluno>(
                        value: aluno,
                        child: Text(aluno.info.nome),
                      );
                    }).toList(),
                    value: current_aluno,
                    onChanged: (Aluno value) {
                      current_aluno = value;
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        Wrap_alunos.add(current_aluno);
                      });
                    },
                  ),
                )
              ],
            ),
            Utils.spaceMediumHeight,
            Wrap(
                children: Wrap_alunos.map((element) {
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      Wrap_alunos.remove(element);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                      width: MediaQuery.of(context).size.width,
                      color: Colors_myclass.black,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        element.info.nome,
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
            Utils.spaceBigHeight,
            Buttons_myclass.Button1(context,
                text: "Criar bate-papo",
                function: () {
                  _formKey.currentState.save();
                  bool valido = _formKey.currentState.validate();
                  if (!valido) {
                    return ;
                  }

                  List<String> emails_participantes = Wrap_alunos.map((e) => e.info.email).toList();
                  emails_participantes.add(turma.Professor.email);

                  ChatController().add(turma.id,nomeChat,emails_participantes);
                  Nav.pop(context);
                },
                colorbackground: Colors_myclass.black)
          ],
        ),
      ),
    );
  }
}
