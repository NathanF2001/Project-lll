import 'package:flutter/cupertino.dart';
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
      backgroundColor: Colors_myclass.main_color,
      body: _formRegister(),
    );
  }

  _formRegister() {
    return Column(
      children: [
        Expanded(
          flex: 1,
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
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(200))),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Utils.spaceBigHeight,
                  Container(
                    padding: EdgeInsets.only(left: 70),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        hintText: "Insira seu nome",
                        hintStyle: TextStyle(
                          fontSize: 24,
                        ),
                        labelText: "Nome",
                        labelStyle:
                            TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                  ),
                  Utils.spaceSmallHeight,
                  Container(
                    padding: EdgeInsets.only(left: 35),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        hintText: "Insira seu e-mail",
                        hintStyle: TextStyle(
                          fontSize: 24,
                        ),
                        labelText: "E-mail",
                        labelStyle:
                            TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                  ),
                  Utils.spaceSmallHeight,
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        hintText: "Insira sua senha",
                        hintStyle: TextStyle(
                          fontSize: 24,
                        ),
                        labelText: "Senha",
                        labelStyle:
                            TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                  ),
                  Utils.spaceSmallHeight,
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        hintText: "Confirme sua senha",
                        hintStyle: TextStyle(
                          fontSize: 24,
                        ),
                        labelText: "Confirmar senha",
                        labelStyle:
                            TextStyle(fontSize: 24, color: Colors.black),
                      ),
                    ),
                  ),
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
