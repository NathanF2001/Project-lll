import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/ActivityController.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/controller/TurmaController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/models/Turma.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/home_user/CreateTurma.dart';
import 'package:myclass/pages/home_user/ProfilePage.dart';
import 'package:myclass/pages/home_user/TurmasListview.dart';
import 'package:myclass/pages/user_auth/LoginPage.dart';

class UserPage extends StatefulWidget {
  Pessoa user;
  DocumentReference id ;

  UserPage(this.user, this.id);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Pessoa get  user => widget.user;
  void set user(newvalue) => widget.user = newvalue;

  DocumentReference get id => widget.id;
  int index_atual = 0;
  String code;
  String search_string = '';


  @override
  Widget build(BuildContext context) {

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
        onChanged: (value) {
          setState(() {
            search_string = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: "Pesquisar por turmas",
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
              Nav.push(context, CreateTurma(user, id));
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
              Nav.push(context, LoginPage(),replace: true);
            },
          ),
        ],
      ),
    );
  }

  _listviewTurmas() {
    return TurmasListView(user,id,search_string);
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
              validator: (value) => value.length != 6 ? "Código inválido (6 caracteres)" : null,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: () async {
                _formKey.currentState.save();
                bool validate = _formKey.currentState.validate();
                if (!validate){
                  return ;
                }

                // Get referencia da turma
                QueryDocumentSnapshot pointer_turma =
                    await TurmaController().get_turmabycode(code);
                if (pointer_turma == null){
                  print("PIU");
                  return _ErrorAlertDialog();
                }
                DocumentReference id_turma = pointer_turma.reference;

                // Pegar dados da turma
                Turma turma = await TurmaController().get_turma(pointer_turma);

                // Adicionar aluno na Turma
                DocumentReference ref_aluno = await TurmaController().addAlunoTurma(id_turma, id);

                // Atualizar a lista de turma do aluno
                user =
                    await PessoaController().update_Turmas(code, id, user);

                // Adicionar todas as atividades existentes na turma como pendente ao aluno
                ActivityController atividade = ActivityController(id_turma.collection("Activity"));
                atividade.addAllActitiviesAluno(ref_aluno);


                setState(() {

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

  _ErrorAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Não foi possível acessar Turma",
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Text(
            "Não existe uma turma com esse código",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            FlatButton(
              onPressed: () => Nav.pop(context),
              child: Text("OK"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }
}
