
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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

    return getRandomString(7);
  }

  static Widget Text_input(
      {@required hintmensage, @required labelmensage, bool show = false, TextInputType key_type = TextInputType.text,
      onsaved,maxLength, double width}) {
    return Container(
      width: width,
      constraints: BoxConstraints(maxHeight: 200),
      child: TextFormField(
          style: TextStyle(
            fontSize: 20,
          ),
          obscureText: show,
          keyboardType: key_type,
          maxLines: (key_type == TextInputType.multiline) ? null : 1,
          maxLength: maxLength,
          onSaved: onsaved,
          decoration: InputDecoration(
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

}
