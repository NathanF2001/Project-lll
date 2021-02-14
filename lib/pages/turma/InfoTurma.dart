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
                          PickedFile image = await ImagePicker()
                              .getImage(source: ImageSource.gallery);
                          File file = File(image.path);

                          String url = await StorageRepo()
                              .uploadFile(file, "Turma/${turma.codigo}.jpg");
                          if (url == null) {
                            return;
                          }
                          turma.UrlTurma = url;
                          setState(() {});

                          QueryDocumentSnapshot doc_turma =
                              await TurmaController()
                                  .get_turmabycode(turma.codigo);
                          String ref_turma = doc_turma.id;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  color: Colors_myclass.white,
                  padding: EdgeInsets.all(16),
                  child: Text(
                    turma.Descricao,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
                turma.Professor.email == user.email
                    ? IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await _showUpdateTurma(context, "Descrição",
                              turma.Descricao, turma.id.id);
                          setState(() {});
                        })
                    : Container()
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors_myclass.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                        color: Colors_myclass.black,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32),
                            bottomRight: Radius.circular(32))),
                    child: Text(
                      "Nome professor",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors_myclass.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      turma.Professor.nome,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Utils.spaceSmallHeight,
                  Container(
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                        color: Colors_myclass.black,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32),
                            bottomRight: Radius.circular(32))),
                    child: Text(
                      "Contato",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors_myclass.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      turma.Professor.email,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Utils.spaceSmallHeight,
                  Container(
                    padding: EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                        color: Colors_myclass.black,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32),
                            bottomRight: Radius.circular(32))),
                    child: Text(
                      "Código da turma",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                          color: Colors_myclass.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      turma.codigo,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Utils.spaceBigHeight
                ],
              ),
            )
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
