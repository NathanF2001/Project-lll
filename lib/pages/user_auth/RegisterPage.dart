import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/nav.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors_myclass.main_color,
      body: SingleChildScrollView(
        child: _formRegister(),
      )
    );
  }

  _formRegister() {
    return Column(
      children: [
        Container(
          height: 175,
            padding: EdgeInsets.only(top: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(icon: Icon(Icons.arrow_back_ios_outlined),color: Colors.white, onPressed: () => Nav.pop(context)),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 40, bottom: 16),
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
            )
        ),
        Container(
          height: MediaQuery.of(context).size.height - 175,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(300))),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Utils.spaceBigHeight,
                  Utils.Text_input(hintmensage: "Insira seu nome", labelmensage: "Nome"),
                  Utils.spaceSmallHeight,
                  Utils.Text_input(hintmensage: "Insira seu e-mail", labelmensage: "E-mail"),
                  Utils.spaceSmallHeight,
                  Utils.Text_input(hintmensage: "Insira sua senha", labelmensage: "Senha",show: true),
                  Utils.spaceSmallHeight,
                  Utils.Text_input(hintmensage: "Confirme sua senha", labelmensage: "Confirmar senha",show: true),
                  Utils.spaceBigHeight,
                  Buttons_myclass.Button1(context,
                      text: "Criar Conta", function: () => _showAlertDialog()),
                  Utils.spaceBigHeight,
                ],
              ),
            ),
          ),
        )
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
