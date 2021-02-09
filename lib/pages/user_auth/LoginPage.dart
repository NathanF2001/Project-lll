import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/nav.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildLoginPage(),
      backgroundColor: Colors_myclass.app_color,
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
                borderRadius: BorderRadius.only(topLeft: Radius.circular(300))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Utils.Text_input(hintmensage: "Insira seu e-mail", labelmensage: "E-mail",onsaved: (value) {email = value;}),
                      Utils.spaceMediumHeight,
                      Utils.Text_input(hintmensage: "Insira sua senha", labelmensage: "Senha",show: true,onsaved: (value) {password = value;}),
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
                        color: Colors_myclass.app_color,
                      ),
                    ),
                  ),
                ),
                Utils.spaceBigHeight,
                Button_Login(_formKey, email, password),
                Utils.spaceSmallHeight,
                Container(
                  width: 300,
                  child: GoogleAuthButton(
                    onPressed: (){ AuthController().signWithGoogle(context);},
                  )
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
                        color: Colors_myclass.app_color,
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

class Button_Login extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email;
  String password;

  Button_Login(this.formKey, this.email, this.password);

  @override
  Widget build(BuildContext context) {
    return Buttons_myclass.Button1(context, text: "Entrar", colorbackground: Colors_myclass.black,function: () async{

      formKey.currentState.save();

      final error = await AuthController().signWithEmailAndPassword(context, email, password);

      Utils.showSnackbar(context,error);

    });
  }
}


