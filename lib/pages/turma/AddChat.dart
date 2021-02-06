import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ChatController.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Turma.dart';

import '../../nav.dart';

class AddChat extends StatefulWidget {
  @override
  _AddChatState createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  final _formKey = GlobalKey<FormState>();
  List<Future<Aluno>> alunos;
  Turma turma;
  Aluno current_aluno;
  String nomeChat;
  List<Aluno> alunos_da_turma = [];

  List<Aluno> Wrap_alunos = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero).then((value) async {
      List<dynamic> values = Nav.getRouteArgs(context);
      turma = values[0];
      alunos = values[1];

      await _transformFuture();
      setState(() {});
    });
  }

  void _transformFuture() async {
    await alunos.forEach((element) {
      element.then((value) => alunos_da_turma.add(value));
    });
  }

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
                    alunos_da_turma.map<DropdownMenuItem<Aluno>>((aluno) {
                      return DropdownMenuItem<Aluno>(
                        value: aluno,
                        child: Text(aluno.info.nome),
                      );
                    }).toList(),
                    value: current_aluno,
                    onChanged: (value) {
                      current_aluno = value;
                    },
                    onSaved: (newValue) {

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
                        print(current_aluno);
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
                  ChatController().add(turma.id,nomeChat,Wrap_alunos);
                },
                colorbackground: Colors_myclass.black)
          ],
        ),
      ),
    );
  }
}
