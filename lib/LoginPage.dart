import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/RegisterPage.dart';
import 'package:myclass/UserPage.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/nav.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildLoginPage(),
      backgroundColor: Colors_myclass.main_color,
    );
  }

  _buildLoginPage() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 40),
            child: Text(
              "MyClass",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 55,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(200))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 320,
                        child: TextFormField(
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(16))
                                ),
                                hintText: "Insira seu e-mail",
                                hintStyle: TextStyle(
                                  fontSize: 24,
                                ),
                                labelText: "E-mail",
                                labelStyle: TextStyle(fontSize: 24, color: Colors.black))
                        ),
                      ),
                      Utils.spaceMediumHeight,
                      Container(
                        width: 320,
                        child: TextFormField(
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16))
                              ),
                                hintText: "Insira sua senha",
                                hintStyle: TextStyle(
                                  fontSize: 24,
                                ),
                                labelText: "Senha",
                                labelStyle: TextStyle(fontSize: 24, color: Colors.black))
                        ),
                      ),
                    ],
                  ),
                ),
                Utils.spaceMediumHeight,
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Esqueci a senha",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF13CE61),
                      ),
                    ),
                  ),
                ),
                Utils.spaceBigHeight,
                Buttons_myclass.Button1(context, text: "Entrar", function: () {
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
                    },
                  ];
                  Nav.pushname(context, "/home", arguments: Turmas);
                }),
                Utils.spaceSmallHeight,
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {},
                ),
                Utils.spaceBigHeight,
                InkWell(
                  onTap: () => Nav.pushname(context, "/register"),
                  child: Container(
                    child: Text(
                      "Registre-se",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF13CE61),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
