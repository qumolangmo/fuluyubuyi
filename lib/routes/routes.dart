import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/HomePage.dart';


var routes = {
  "/":(context)=>HomePage(),
};

Route? onGenerateRoute(RouteSettings settings){
  final String? name = settings.name;
  final Function? yourPage = routes[name];

  if(yourPage != null){
    if(settings.arguments!=null){
      final Route route = MaterialPageRoute(
        builder: ((context) => yourPage(context, arguments: settings.arguments)),
      );
      return route;
    }
    else{
      final Route route = MaterialPageRoute(
        builder: ((context) => yourPage(context)),
      );
      return route;
    }
  }
  return null;
  
}