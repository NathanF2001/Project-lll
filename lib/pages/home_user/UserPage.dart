import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/AlunoController.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/controller/TurmaController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/ProfilePage.dart';
import 'package:myclass/pages/home_user/TurmasListview.dart';
import 'package:myclass/pages/user_auth/LoginPage.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Pessoa user;
  DocumentReference id;
  int index_atual = 0;
  String code;

  @override
  Widget build(BuildContext context) {
    List<dynamic> values = Nav.getRouteArgs(context);
    user = values[0];
    id = values[1];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        bottom: PreferredSize(
          child: _SearchView(),
          preferredSize: Size(1, 80),
        ),
        title: Text(
          "MyClass",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: _DrawerUser(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          _showAlertDialog();
        },
        backgroundColor: Colors_myclass.app_color,
        child: Icon(Icons.add),
      ),
      body: _listviewTurmas(),
    );
  }

  _SearchView() {
    return Container(
      color: Colors_myclass.black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.125,
      padding: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: "Pesquisar turmas",
          labelStyle: TextStyle(
            color: Colors.grey,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  _DrawerUser() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Utils.text_style(user.nome),
              accountEmail: Utils.text_style(user.email),
              currentAccountPicture: user.UrlFoto == ""
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(user.UrlFoto),
                    )),
          ListTile(
            title: Text("Alterar Perfil",
                style: TextStyle(fontWeight: FontWeight.normal)),
            leading: Icon(Icons.person),
            onTap: () => Nav.push(context, ProfilePage(user)),
          ),
          ListTile(
            title: Text("Preencher dados socioeconômicos",
                style: TextStyle(fontWeight: FontWeight.normal)),
            leading: Icon(Icons.accessibility),
            onTap: () {},
          ),
          ListTile(
            title: Text("Criar Turma",
                style: TextStyle(fontWeight: FontWeight.normal)),
            leading: Icon(Icons.add_circle_outline),
            onTap: () {
              Nav.pushname(context, "/create-turma", arguments: [user, id]);
            },
          ),
          Spacer(),
          ListTile(
            contentPadding: EdgeInsets.all(16),
            title:
                Text("Logout", style: TextStyle(fontWeight: FontWeight.normal)),
            leading: Icon(Icons.logout),
            onTap: () {
              AuthController().logout();
              Nav.push(context, LoginPage());
            },
          ),
        ],
      ),
    );
  }

  _listviewTurmas() {
    return TurmasListView(user,id);
  }

  _showAlertDialog() {
    final _formKey = GlobalKey<FormState>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            "Digite o código da turma",
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              style: TextStyle(
                fontSize: 18,
              ),
              decoration: InputDecoration(
                  hintText: "Insira código da turma",
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  labelText: "Código da turma",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.black)),
              onSaved: (String value) {
                code = value;
              },
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () async {

                _formKey.currentState.save();
                QuerySnapshot ref =
                    await TurmaController().get_turmabycode(code);
                DocumentReference id_turma = ref.docs.first.reference;

                final json_turma = ref.docs.first.data();
                Turma turma = Turma.fromJson(json_turma);

                DocumentReference ref_aluno = await TurmaController().addAlunoTurma(id_turma, turma, id);
                final info_user =
                    await PessoaController().update_Turmas(id_turma, id, user);

                ActivityController atividade = ActivityController(turma.id.collection("Activity"));
                atividade.addAllActitiviesAluno(ref_aluno);

                setState(() {
                  user = info_user;
                });
                Nav.pop(context);
              },
              child: Text("Entrar"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }
}
