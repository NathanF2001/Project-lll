import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/CreateTurma.dart';
import 'package:myclass/LoginPage.dart';
import 'package:myclass/TurmasModel.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/nav.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final atual_tile = [true, false, false, false, false];
  int index_atual = 0;
  bool show_search = false;
  List<dynamic> Turmas = [
    {
      "Nome_turma": "Engenharia para sistemas de informação l",
      "Nome_professor": "Cleviton Monteiro",
      "Info_turma":
          "Nesse curso introdutório sobre engenharia de software (ES) para sistemas "
              "de informação serão discutidos conceitos gerais da área de ES com aplicação prática dos conteúdos."
    },
    {
      "Nome_turma": "Desenvolvimento de Sistemas de Informação",
      "Nome_professor": "Gabriel Junior",
      "Info_turma":
          "Proporcionar aos estudantes uma experiência próxima à encontrada em projetos de"
              "desenvolvimento de sistemas de informação comerciais com linguagens orientadas a objetos,"
              "com o embasamento teórico-prático das ferramentas e métodos utilizados."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "MyClass",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                setState(() {
                  show_search = !show_search;
                });
              },
              child: Icon(Icons.search, color: Colors.white))
        ],
      ),
      drawer: _DrawerUser(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
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
                content: TextFormField(
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
                ),
                actions: [
                  FlatButton(
                    onPressed: () => Nav.pop(context),
                    child: Text("Entrar"),
                    textColor: Colors.black87,
                  )
                ],
              );
            },
          );
        },
        backgroundColor: Colors_myclass.main_color,
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          _SearchView(),
          Padding(
            padding: EdgeInsets.all(16),
            child: _listviewTurmas(),
          )
        ],
      ),
    );
  }

  _SearchView() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      color: Colors_myclass.main_color,
      width: MediaQuery.of(context).size.width,
      height: show_search ? 80 : 0,
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: TextField(
          decoration: InputDecoration(
            labelText: "Pesquisar turmas",
            labelStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  _DrawerUser() {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Utils.text_style("Username"),
            accountEmail: Utils.text_style("Username@anyemail.com"),
            currentAccountPicture: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            title: Text("Turmas",
                style: TextStyle(
                    fontWeight:
                        atual_tile[0] ? FontWeight.bold : FontWeight.normal)),
            leading: Icon(Icons.class__outlined),
            onTap: () {
              setState(() {
                atual_tile[index_atual] = false;
                atual_tile[0] = true;
                index_atual = 0;
              });
            },
          ),
          ListTile(
            title: Text("Alterar Perfil",
                style: TextStyle(
                    fontWeight:
                        atual_tile[1] ? FontWeight.bold : FontWeight.normal)),
            leading: Icon(Icons.person),
            onTap: () {
              setState(() {
                atual_tile[index_atual] = false;
                atual_tile[1] = true;
                index_atual = 1;
              });
            },
          ),
          ListTile(
            title: Text("Preencher dados socioeconômicos",
                style: TextStyle(
                    fontWeight:
                        atual_tile[2] ? FontWeight.bold : FontWeight.normal)),
            leading: Icon(Icons.accessibility),
            onTap: () {
              setState(() {
                atual_tile[index_atual] = false;
                atual_tile[2] = true;
                index_atual = 2;
              });
            },
          ),
          ListTile(
            title: Text("Criar Turma",
                style: TextStyle(
                    fontWeight:
                        atual_tile[3] ? FontWeight.bold : FontWeight.normal)),
            leading: Icon(Icons.add_circle_outline),
            onTap: () {
              setState(() {
                atual_tile[index_atual] = false;
                atual_tile[3] = true;
                index_atual = 3;
              });
              Nav.push(context, CreateTurma(Turmas));
            },
          ),
          Spacer(),
          ListTile(
            contentPadding: EdgeInsets.all(16),
            title: Text("Logout",
                style: TextStyle(
                    fontWeight:
                        atual_tile[4] ? FontWeight.bold : FontWeight.normal)),
            leading: Icon(Icons.logout),
            onTap: () {
              setState(() {
                atual_tile[index_atual] = false;
                atual_tile[4] = true;
                index_atual = 4;
              });
              Nav.push(context, LoginPage());
            },
          ),
        ],
      ),
    );
  }

  _listviewTurmas() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: Turmas.length,
        itemBuilder: (context, index) {
          final Turma = Turmas[index];
          return TurmasModel(Turma);
        });
  }
}
