import 'package:flutter/material.dart';

final Nav = _Nav();
class _Nav{

  Future push(BuildContext context,Widget page,{bool replace = false}){

    if(replace) {
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => page ));
    }

    return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }
}