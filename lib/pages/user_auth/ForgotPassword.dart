import 'package:flutter/material.dart';
import 'package:myclass/Button.dart';
import 'package:myclass/Colors.dart';
import 'package:myclass/Utils.dart';
import 'package:myclass/controller/LoginController.dart';
import 'package:myclass/nav.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Esqueceu a senha"),
      ),
      resizeToAvoidBottomInset: false,
      body: _buildForgotPassPage(),
      backgroundColor: Colors_myclass.white,
    );
  }

  _buildForgotPassPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Digite seu email",
          style: TextStyle(fontSize: 24, color: Colors_myclass.app_color),
        ),
        Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Utils.Text_input(
                hintmensage: "Digite seu email",
                labelmensage: "Email",
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
          ),
        ),
        Utils.spaceBigHeight,
        Buttons_myclass.Button1(context,
            text: "Enviar código",
            colorbackground: Colors_myclass.black, function: () async {

          _formKey.currentState.save();

          final valido = _formKey.currentState.validate();
          if (!valido) {
            return false;
          }


          // Mandar Email para recuperar a senha
          final status = await AuthController().sendEmailForgotPass(email);

          if (status != "Ok"){
            _showAlertDialog("Error", status);
          }else{
            await _showAlertDialog("Email Enviado", "Cheque seu e-mail e redefina sua senha");
          }
        })
      ],
    );
  }

  _showAlertDialog(Title_mensage,content_mensage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Title_mensage,
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Text(
            content_mensage,
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
