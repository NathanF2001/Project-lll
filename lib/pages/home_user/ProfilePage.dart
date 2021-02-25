import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/controller/StorageRepo.dart';
import 'package:myclass/controller/TurmaController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/user_auth/LoginPage.dart';

class ProfilePage extends StatefulWidget {
  Pessoa pessoa;
  DocumentReference id_user;
  DocumentReference id_SE;

  ProfilePage(this.pessoa, this.id_user,this.id_SE);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Pessoa get pessoa => widget.pessoa;

  set pessoa(Pessoa newvalue) {
    pessoa = newvalue;
  }

  DocumentReference get id_user => widget.id_user;
  DocumentReference get id_SE => widget.id_SE;

  @override
  Widget build(BuildContext context) {
    return Utils().Scaffold_myclass(title: "Perfil", body: _bodyProfile(),leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Nav.pop(context, result: pessoa);
      },
    ),);
  }

  _bodyProfile(){
    return Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Utils.spaceBigHeight,
              Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      pessoa.UrlFoto == ""
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
                        backgroundImage: NetworkImage(pessoa.UrlFoto),
                      ),
                      FlatButton(
                          onPressed: () async {
                            String url =
                            await PessoaController().update_UrlFoto(pessoa);
                            pessoa.UrlFoto = url;
                            setState(() {});
                            await PessoaController()
                                .updateUser(pessoa, id_user.id);
                          },
                          child: Text(
                            "Mudar imagem",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ))
                    ],
                  )),
              Utils.spaceMediumHeight,
              Utils().infoTemplate(context,"Nome", pessoa.nome, button: true,
                  function: () async {
                    Pessoa new_value = await Utils.showUpdateInfo(
                        context, "Nome", pessoa.nome, pessoa, id_user);
                    setState(() {
                      pessoa.nome = new_value.nome;
                    });
                  }),
              Utils().infoTemplate(
                context,
                "Email",
                pessoa.email,
              ),
              Utils().infoTemplate(context,"Descrição", pessoa.descricao, button: true,
                  function: () async {
                    Pessoa new_value = await Utils.showUpdateInfo(
                        context, "Descrição", pessoa.descricao, pessoa, id_user);
                    setState(() {
                      pessoa.descricao = new_value.descricao;
                    });
                  }),
              Utils.spaceBigHeight,
              Center(
                child: Buttons_myclass.Button1(context, text: "Deletar conta",colorbackground: Colors.red,
                    function: (){
                  _showAlertDialog("Deletar conta", "Tem certeza que deseja deletar sua conta?");
                    }),
              ),
              Utils.spaceBigHeight
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
                print(id_user);
                List<DocumentReference> ref_turmas = await TurmaController().getAllRefTurma(pessoa.Turmas_reference);
                Future.forEach(ref_turmas, (DocumentReference ref_turma) async{
                  DocumentReference ref_aluno = await AlunoController().deleteAluno(ref_turma, id_user);
                  TurmaController().updateNumberAlunos(ref_turma,-1);
                  ActivityController(ref_turma.collection("Activity")).deleteAlunoActivities(ref_aluno);

                });
                PessoaController().delete_SE(id_SE);
                PessoaController().delete_user(id_user);
                PessoaController().delete_auth_user(FirebaseAuth.instance.currentUser);
                Nav.push(context, LoginPage(),replace: true);
              },
              child: Text("Sim"),
              textColor: Colors.black87,
            ),
            FlatButton(
              onPressed: () => Nav.pop(context),
              child: Text("Não"),
              textColor: Colors.black87,
            ),

          ],
        );
      },
    );
  }

}
