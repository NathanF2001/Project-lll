import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myclass/Colors.dart';

class Buttons_myclass {
  static Button1(context,{@required text, function,textcolor = Colors.white,colorbackground, fontsize = 26.0}) {
    return RaisedButton(
      onPressed: function,
      textColor: textcolor,
      color: colorbackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
      ),
      child: Container(
        width: 250,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontsize,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
