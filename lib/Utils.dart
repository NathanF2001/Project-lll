
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/LoginPage.dart';
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

  static Widget Text_input(
      {@required hintmensage, @required labelmensage, bool show = false, TextInputType key_type = TextInputType.text,
      onsaved,maxLength}) {
    return TextFormField(
      obscureText: show,
      onSaved: onsaved,
      keyboardType: key_type,
      maxLength: maxLength,
      maxLines: key_type == TextInputType.multiline ? null : 1,
      style: TextStyle(
        fontSize: 20,
      ),
      decoration: InputDecoration(
          hintText: hintmensage,
          hintStyle: TextStyle(
            fontSize: 24,
          ),
          labelText: labelmensage,
          labelStyle: TextStyle(fontSize: 24, color: Colors.black)),
    );
  }

}
