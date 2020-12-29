import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:myclass/Button.dart';
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
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Utils.logo(context),
            ),
            Utils.spaceBigHeight,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Falta adicionar o validor
                  Utils.Text_input(
                      hintmensage: "Insira seu e-mail", labelmensage: "E-mail"),
                  Utils.Text_input(
                      hintmensage: "Insira sua senha",
                      labelmensage: "Senha",
                      show: true),
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
            Buttons_myclass.Button1(context, text: "Entrar", function: () => Nav.push(context, UserPage(),replace: true)),
            Utils.spaceSmallHeight,
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () {},
            ),
            Utils.spaceBigHeight,
            InkWell(
              onTap: () => Nav.push(context,RegisterPage()),
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
    );
  }
}
