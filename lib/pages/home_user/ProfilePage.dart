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

  ProfilePage(this.pessoa,this.id_user);

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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Perfil",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Nav.pop(context,result:pessoa);
          },
        ),
      ),
      body: Container(
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
                              PickedFile image = await ImagePicker()
                                  .getImage(source: ImageSource.gallery);
                              File file = File(image.path);

                              String url =
                              await StorageRepo().uploadFile(file,"User/${pessoa.email}.jpg");
                              pessoa.UrlFoto = url;
                              setState(() {

                              });
                              await PessoaController().updateUser(
                                  pessoa, id_user.id);
                            },
                            child: Text(
                              "Mudar imagem",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 18),
                            ))
                      ],
                    )),
                Utils.spaceMediumHeight,
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  decoration: BoxDecoration(
                      color: Colors_myclass.black,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          bottomRight: Radius.circular(32))),
                  child: Text(
                    "Nome",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors_myclass.white),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.75,
                          child: Text(
                            pessoa.nome,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors_myclass.black),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async{
                              Pessoa new_value = await Utils.showUpdateInfo(
                                  context, "Nome", pessoa.nome, pessoa,id_user);
                              setState(() {
                                pessoa.nome = new_value.nome;
                              });
                            })
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  decoration: BoxDecoration(
                      color: Colors_myclass.black,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          bottomRight: Radius.circular(32))),
                  child: Text(
                    "Email",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors_myclass.white),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.75,
                          child: Text(
                            pessoa.email,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors_myclass.black),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.75,
                  decoration: BoxDecoration(
                      color: Colors_myclass.black,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          bottomRight: Radius.circular(32))),
                  child: Text(
                    "Descrição",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors_myclass.white),
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.75,
                          child: Text(
                            pessoa.descricao,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w400,
                                color: Colors_myclass.black),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              Pessoa new_value = await Utils.showUpdateInfo(
                                  context, "Descrição", pessoa.descricao,
                                  pessoa,
                                  id_user);
                              setState(() {
                                pessoa.descricao = new_value.descricao;
                              });
                            })
                      ],
                    )
                ),
              ],
            ),
          )),
    );
  }
}

