import 'package:flutter/material.dart';

final Nav = _Nav();
class _Nav{

  Future push(BuildContext context,Widget page,{bool replace = false}){

    if(replace) {
      return Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => page ));
    }

    return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  void pushname(context, routeName, {arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  Object getRouteArgs(context){
    return ModalRoute.of(context).settings.arguments;
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }
}