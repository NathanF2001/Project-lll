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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "MyClass - Registrar",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _formRegister(),
    );
  }

  _formRegister() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Utils.logo(context),
              Utils.spaceBigHeight,
              Utils.Text_input(
                  hintmensage: "Insira seu nome", labelmensage: "Nome"),
              Utils.spaceSmallHeight,
              Utils.Text_input(
                  hintmensage: "Insira seu E-mail", labelmensage: "E-mail"),
              Utils.spaceSmallHeight,
              Utils.Text_input(
                  hintmensage: "Insira seu senha", labelmensage: "Senha"),
              Utils.spaceSmallHeight,
              Utils.Text_input(
                  hintmensage: "Insira sua senha novamente",
                  labelmensage: "Confirmar senha"),
              Utils.spaceBigHeight,
              Buttons_myclass.Button1(context,
                  text: "Criar Conta",
                  function: () => _showAlertDialog()),
              Utils.spaceBigHeight,
            ],
          ),
        ));
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
