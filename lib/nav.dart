import 'package:flutter/material.dart';

final Nav = _Nav();
class _Nav{

  Future push(BuildContext context,Widget page,{bool replace = false}){

    if(replace) {
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => page ));
    }

    return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  Object pushname(context, routeName, {arguments,bool replace = false}) {

    if (replace){
      return Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
    }

    return Navigator.pushNamed(context, routeName, arguments: arguments);


  }

  Object getRouteArgs(context){
    return ModalRoute.of(context).settings.arguments;
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }
}