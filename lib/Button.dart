import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Buttons_myclass {
  static Button1(context,{@required text, function,textcolor = Colors.white,colorbackground}) {
    return RaisedButton(
      onPressed: function,
      textColor: textcolor,
      color: colorbackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
        side: BorderSide(color: Color(0xFF13CE61))
      ),
      child: Container(
        width: 250,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
