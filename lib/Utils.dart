
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';
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
            fontFamily: "Roboto",
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
                fontFamily: "Roboto",
                fontSize: 24,
              ),
              labelText: labelmensage,
              labelStyle: TextStyle(fontSize: 24, color: Colors.black,fontFamily: "Roboto",))
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

  infoTemplate(context,text_title, text_label, {function, button = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * 0.75,
          decoration: BoxDecoration(
              color: Colors_myclass.black,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                  bottomRight: Radius.circular(32))),
          child: Text(
            text_title,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors_myclass.white),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Text(
                text_label,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                    color: Colors_myclass.black),
              ),
            ),
            button == true
                ? IconButton(icon: Icon(Icons.edit), onPressed: function)
                : Container()
          ]),
        )
      ],
    );
  }

  Scaffold_myclass({@required  String title,@required body,Widget bottom_appbar , Widget drawer,float,List<Widget> actions,leading,key_scaffold,
  resize = false}){
    return Scaffold(
      resizeToAvoidBottomInset: resize,
      key: key_scaffold,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        bottom: bottom_appbar,
        leading: leading,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        actions: actions,
      ),
      drawer: drawer,
      floatingActionButton: float,
      body: body,
    );
  }

  statusAlertDialog(context,title_text, content_text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title_text,
            style: Theme.of(context).textTheme.headline5,
          ),
          content: Text(
            content_text,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          actions: [
            FlatButton(
              onPressed: () => Nav.pop(context),
              child: Text("OK"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }

  InputAlertDialog(context,title,initial_value, hinttext,labeltext,onsaved,function,GlobalKey<FormState> formkey) {
    final _formKey = formkey;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          titlePadding: EdgeInsets.all(16),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              style: TextStyle(
                fontSize: 18,
              ),
              initialValue: initial_value,
              decoration: InputDecoration(
                  hintText: hinttext,
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  labelText: labeltext,
                  labelStyle: TextStyle(fontSize: 18, color: Colors.black)),
              onSaved: onsaved,
              validator: (value) => value == "" ? "Entrada inválido (vazio)" : null,
            ),
          ),
          actions: [
            FlatButton(
              onPressed: function,
              child: Text("Atualizar"),
              textColor: Colors.black87,
            )
          ],
        );
      },
    );
  }

}
