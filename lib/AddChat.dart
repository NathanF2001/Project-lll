import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Utils.dart';

class AddChat extends StatefulWidget {
  @override
  _AddChatState createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  final _formKey = GlobalKey<FormState>();
  String current_aluno;
  List<String> Alunos = [
    "Todos os alunos",
    "Aluno A",
    "Aluno B",
    "Aluno C",
    "Aluno D",
    "Aluno E",
    "Aluno F",
    "Aluno G",
    "Aluno H",
    "Aluno I",
    "Aluno J",
    "Aluno K"
  ];

  List<Widget> Wrap_alunos = [];

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
                labelmensage: "Nome do bate-papo"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(labelText: 'Alunos*'),
                    items: Alunos.map<DropdownMenuItem<String>>((aluno) {
                      return DropdownMenuItem<String>(
                        value: aluno,
                        child: Text(aluno),
                      );
                    }).toList(),
                    value: "Todos os alunos",
                    onChanged: (value) {
                      current_aluno = value;
                    },
                    onSaved: (newValue) {},
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
                        Wrap_alunos.add(Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              current_aluno,
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.grey[100]));
                      });
                    },
                  ),
                )
              ],
            ),
            Wrap(
              children: Wrap_alunos,
            ),
            Utils.spaceBigHeight,
            Buttons_myclass.Button1(context, text: "Criar bate-papo",function: (){})
          ],
        ),
      ),
    );
  }
}
