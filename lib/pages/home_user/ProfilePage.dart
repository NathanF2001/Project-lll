import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/controller/StorageRepo.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/nav.dart';

class ProfilePage extends StatefulWidget {
  Pessoa pessoa;
  DocumentReference id_user;

  ProfilePage(this.pessoa, this.id_user);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Pessoa get pessoa => widget.pessoa;

  set pessoa(Pessoa newvalue) {
    pessoa = newvalue;
  }

  DocumentReference get id_user => widget.id_user;

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
            ],
          ),
        ));
  }
}
