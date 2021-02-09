import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/nav.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String nome;
  String senha;
  String csenha;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors_myclass.app_color, body: _formRegister());
  }

  _formRegister() {
    return ListView(
      children: [
        Container(
          child: Container(
            padding: EdgeInsets.only(top: 16),
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    color: Colors.white,
                    onPressed: () => Nav.pop(context)),
                Container(
                  child: Text(
                    "Registrar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 55,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(150))),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Utils.spaceBigHeight,
                  Utils.Text_input(
                      hintmensage: "Insira seu nome",
                      labelmensage: "Nome",
                      onsaved: (value) {
                        nome = value;
                      },
                      validator: (String value) =>
                          value.isEmpty ? "Nome inválido (vazio)" : null),
                  Utils.spaceSmallHeight,
                  Utils.Text_input(
                      hintmensage: "Insira seu e-mail",
                      labelmensage: "E-mail",
                      onsaved: (value) {
                        email = value;
                      },
                      validator: (String value) {
                        bool validemail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);

                        if (!validemail){
                          return "Email inválido";
                        }
                      }),
                  Utils.spaceSmallHeight,
                  Utils.Text_input(
                      hintmensage: "Insira sua senha",
                      labelmensage: "Senha",
                      show: true,
                      onsaved: (value) {
                        senha = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty){
                          return "Senha inválida (vazio)";
                        }
                        if (value.length < 6){
                          return "Senha com pouco caracteres (Min.6)";
                        }}),
                  Utils.spaceSmallHeight,
                  Utils.Text_input(
                      hintmensage: "Confirme sua senha",
                      labelmensage: "Confirmar senha",
                      show: true,
                      onsaved: (value) {
                        csenha = value;
                      },
                      validator: (String value) =>
                          senha != value ? "Senhas não batem" : null),
                  Utils.spaceBigHeight,
                  Buttons_myclass.Button1(context,
                      colorbackground: Colors_myclass.black,
                      text: "Criar Conta", function: () async {
                    _formKey.currentState.save();

                    final valido = _formKey.currentState.validate();
                    if (!valido) {
                      return false;
                    }
                    String ok = await AuthController()
                        .cadastrar(context, nome, email, senha);
                    if (ok == "ok") {
                      _showAlertDialog();
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Bem-vindo",
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Text(
            "Sua conta foi criada com sucesso",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            FlatButton(
              onPressed: () => Nav..pop(context)..pop(context),
              child: Text("OK"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }
}
