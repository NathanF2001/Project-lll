import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/nav.dart';
import 'package:myclass/pages/user_auth/ForgotPassword.dart';
import 'package:myclass/pages/user_auth/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: _buildLoginPage(),
      backgroundColor: Colors_myclass.app_color,
    );
  }

  _buildLoginPage() {
    return Wrap(
      children: [
        Container(
          height: 150,
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
        Container(
          padding: EdgeInsets.all(32),
          height: MediaQuery.of(context).size.height-150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(150))),
          child: Wrap(
            runAlignment: WrapAlignment.spaceEvenly,
            alignment: WrapAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Utils.Text_input(hintmensage: "Insira seu e-mail",
                        labelmensage: "E-mail",
                        onsaved: (value) {
                          email = value;
                        },
                        validator: (String value) {
                          bool validemail = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);

                          if (!validemail) {
                            return "Email inválido";
                          }
                        }),
                    Utils.spaceMediumHeight,
                    Utils.Text_input(hintmensage: "Insira sua senha",
                        labelmensage: "Senha",
                        show: true,
                        onsaved: (value) {
                          password = value;
                        },
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Senha inválida (vazio)";
                          }
                          if (value.length < 6) {
                            return "Senha com pouco caracteres (Min.6)";
                          }
                        }),

                  ],
                ),
              ),
              Utils.spaceBigHeight,
              InkWell(
                onTap: () {
                  Nav.push(context, ForgotPassword());
                },
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Text(
                    "Esqueci a senha",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors_myclass.app_color,
                    ),
                  ),
                ),
              ),
              Utils.spaceBigHeight,
              Buttons_myclass.Button1(context, text: "Entrar",
                  colorbackground: Colors_myclass.black,
                  function: () async {
                    _formKey.currentState.save();

                    final valido = _formKey.currentState.validate();
                    if (!valido) {
                      return false;
                    }

                    final error = await AuthController()
                        .signWithEmailAndPassword(context, email, password);

                    if (error != null){
                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error)));
                    }


                  }),
              Utils.spaceSmallHeight,
              Container(
                  width: 300,
                  child: GoogleAuthButton(
                    onPressed: () {
                      AuthController().signWithGoogle(context);
                    },
                  )
              ),
              Utils.spaceBigHeight,
              InkWell(
                onTap: () => Nav.push(context, RegisterPage()),
                child: Container(
                  child: Text(
                    "Registre-se",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors_myclass.app_color,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}


