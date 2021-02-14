
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/controller/PessoaController.dart';
import 'package:myclass/models/Pessoa.dart';
import 'package:myclass/nav.dart';


class Utils {
  static const spaceBigHeight = SizedBox(
    height: 32.0,
  );
  static const spaceMediumHeight = SizedBox(
    height: 16.0,
  );
  static const spaceSmallHeight = SizedBox(
    height: 8.0,
  );

  static showSnackbar(context,text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  static text_style(text,{fontSize,color = Colors.white,fontWeight = FontWeight.normal}){
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        shadows: [
          Shadow(
            blurRadius: 2.5,
            color: Colors.black,
            offset: Offset(2.0,1.0),
          )
        ]
      ),
    );
  }

  static generate_key(int number){
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    String getRandomString(int value) => String.fromCharCodes(Iterable.generate(
        value, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    return getRandomString(number);
  }

  static Widget Text_input(
      {@required hintmensage, @required labelmensage, bool show = false,validator, TextInputType key_type = TextInputType.text,
      onsaved,maxLength, double width,initialvalue}) {
    return Container(
      width: width,
      constraints: BoxConstraints(maxHeight: 150),
      child: TextFormField(
          style: TextStyle(
            fontSize: 20,
          ),
          initialValue: initialvalue,
          obscureText: show,
          keyboardType: key_type,
          maxLines: (key_type == TextInputType.multiline) ? null : 1,
          maxLength: maxLength,
          onSaved: onsaved,
          validator: validator,
          decoration: InputDecoration(
            errorStyle: TextStyle(fontSize: 18,),
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              hintText: hintmensage,
              hintStyle: TextStyle(
                fontSize: 24,
              ),
              labelText: labelmensage,
              labelStyle: TextStyle(fontSize: 24, color: Colors.black))
      ),
    );
  }

  static showUpdateInfo(
      context,
      String campo,
      value,
      Pessoa pessoa,
      id_user
      ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();
        return AlertDialog(
          scrollable: true,
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            "Mudar ${campo.toLowerCase()} usuário",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          content: Form(
              key: _formKey,
              child: Utils.Text_input(
                  hintmensage: "Insira seu ${campo}",
                  labelmensage: "${campo} usuário",
                  onsaved: (value) {
                    switch (campo) {
                      case "Nome":
                        pessoa.nome = value;
                        break;
                      case "Email":
                        pessoa.email = value;
                        break;
                      case "Descrição":
                        pessoa.descricao = value;
                        break;
                    }
                  },
                  initialvalue: value
              )),
          actions: [
            FlatButton(
              onPressed: () async {
                _formKey.currentState.save();

                await PessoaController().updateUser(pessoa, id_user.id);
                Nav.pop(context,result: pessoa);
              },
              child: Text("Mudar"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }

}
