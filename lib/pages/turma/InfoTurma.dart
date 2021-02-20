import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/StorageRepo.dart';
import 'package:myclass/controller/TurmaController.dart';
import 'package:myclass/models/Alunos.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';

class InfoTurma extends StatefulWidget {
  Turma turma;
  Pessoa user;
  List<Aluno> alunos;

  InfoTurma(this.turma, this.user,this.alunos);

  @override
  _InfoTurmaState createState() => _InfoTurmaState();
}

class _InfoTurmaState extends State<InfoTurma> {
  Turma get turma => widget.turma;
  List<Aluno> get alunos => widget.alunos;
  Pessoa get user => widget.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Informação da turma",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors_myclass.white,
      body: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Utils.spaceBigHeight,
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: turma.UrlTurma == ""
                      ? Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 150,
                          ),
                        )
                      : CircleAvatar(
                          radius: 75,
                          backgroundImage: NetworkImage(turma.UrlTurma),
                        ),
                ),
                turma.Professor.email == user.email
                    ? FlatButton(
                        onPressed: () async {

                          String url = await TurmaController().updateUrlFoto(turma);
                          if (url == null) {
                            return;
                          }
                          turma.UrlTurma = url;
                          setState(() {});

                          //Procurando referencia da turma pelo codigo da turma
                          QueryDocumentSnapshot doc_turma =
                              await TurmaController()
                                  .get_turmabycode(turma.codigo);
                          String ref_turma = doc_turma.id;

                          //Atualizando informações da turma (foto)
                          await TurmaController().updateTurma(turma, ref_turma);
                        },
                        child: Text(
                          "Mudar imagem",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ))
                    : Container()
              ],
            ),
            Utils.spaceMediumHeight,
            Container(
              padding: EdgeInsets.all(16),
              color: Colors_myclass.app_color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Text(
                      turma.Nome,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors_myclass.white),
                    ),
                  ),
                  turma.Professor.email == user.email
                      ? IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors_myclass.white,
                          ),
                          onPressed: () async {
                            await _showUpdateTurma(
                                context, "Nome", turma.Nome, turma.id.id);
                            setState(() {});
                          })
                      : Container()
                ],
              ),
            ),
            Utils.spaceBigHeight,
            Utils().infoTemplate(context, "Descrição", turma.Descricao,button: turma.Professor.email == user.email,
                function: () async {
                  await _showUpdateTurma(context, "Descrição",
                      turma.Descricao, turma.id.id);
                  setState(() {});
                }),
            Utils().infoTemplate(context, "Nome professor", turma.Professor.nome),
            Utils().infoTemplate(context, "Contato", turma.Professor.email),
            Utils().infoTemplate(context, "Código da turma", turma.codigo)

          ],
        ),
      )),
    );
  }

  _showUpdateTurma(context, String campo, value, id_turma) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();
        return AlertDialog(
          scrollable: true,
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            "Mudar ${campo.toLowerCase()} usuário",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: Form(
              key: _formKey,
              child: Utils.Text_input(
                  hintmensage: "Insira seu ${campo}",
                  key_type: TextInputType.multiline,
                  labelmensage: "${campo} usuário",
                  onsaved: (value) {
                    switch (campo) {
                      case "Nome":
                        turma.Nome = value;
                        break;
                      case "Descrição":
                        turma.Descricao = value;
                        break;
                    }
                  },
                  initialvalue: value)),
          actions: [
            FlatButton(
              onPressed: () async {
                _formKey.currentState.save();

                await TurmaController().updateTurma(turma, id_turma);

                Nav.pop(context);
              },
              child: Text("Mudar"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }
}
