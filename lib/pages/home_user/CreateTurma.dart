import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/TurmaController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/TurmasTemplate.dart';

class CreateTurma extends StatefulWidget {
  @override
  _CreateTurmaState createState() => _CreateTurmaState();
}

class _CreateTurmaState extends State<CreateTurma> {
  final _formKey = GlobalKey<FormState>();
  List<String> Modalidades = ["", "Teste1", "Teste2", "Teste3"];
  Map<String, dynamic> turma_config = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Criar turma",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _formTurma(),
    );
  }

  _formTurma() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Utils.spaceSmallHeight,
                Utils.Text_input(
                  hintmensage: "Insira nome da Turma",
                  labelmensage: "Nome da turma",
                  onsaved: (newValue) {
                    turma_config["Nome"] = newValue;
                  },
                ),
                Utils.spaceSmallHeight,
                Utils.Text_input(
                  hintmensage: "Descrição da turma",
                  labelmensage: "Descrição",
                  onsaved: (newValue) {
                    turma_config["Descricao"] = newValue;
                  },
                  key_type: TextInputType.multiline
                ),
                Utils.spaceSmallHeight,
                DropdownButtonFormField(
                  decoration: const InputDecoration(
                    labelText: 'Modalidade*',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                  ),
                  items:
                      Modalidades.map<DropdownMenuItem<String>>((modalidade) {
                    return DropdownMenuItem<String>(
                      value: modalidade,
                      child: Text(modalidade),
                    );
                  }).toList(),
                  value: "",
                  onChanged: (value) {},
                  onSaved: (newValue) {
                    turma_config["Modalidade"] = newValue;
                  },
                ),
                Utils.spaceSmallHeight,
                Buttons_myclass.Button1(context, text: "Criar", colorbackground: Colors_myclass.black,function: () async{
                  List<dynamic> values = Nav.getRouteArgs(context);
                  Pessoa user = values[0];
                  final id = values[1];

                  _formKey.currentState.save();
                  user = await TurmaController().create_turma(turma_config,user,id);

                  Nav.pushname(context, "/home",arguments: [user,id]);
                }),
                Utils.spaceBigHeight,
              ],
            ),
          )),
    );
  }
}
