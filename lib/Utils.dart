
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
  /// Logo widget
  static Widget logo(context) {
    return Container(
      width: 280,
      height: 90,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFF13CE61),
        border: Border.all(width: 2, color: Color(0xFF13CE61)),
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Text(
        "MyClass",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 50,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            decoration: TextDecoration.none),
      ),
    );
  }

  static Widget Text_input(
      {@required hintmensage, @required labelmensage, show = false, TextInputType key_type = TextInputType.text,
      onsaved}) {
    return TextFormField(
      obscureText: show,
      onSaved: onsaved,
      keyboardType: key_type,
      maxLines: null,
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
