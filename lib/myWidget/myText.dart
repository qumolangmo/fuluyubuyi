// ignore: file_names
import 'package:flutter/material.dart';
import '../settings.dart';


Map<String, dynamic> textKey = {};

void initGlobalTextKey(){
  for(int i=0; i<parameters.length; i++){
    GlobalKey<_MyTextState> tmp = GlobalKey();
    textKey[parameters[i]]=tmp;
  }
}


class MyText extends StatefulWidget {
  
  final String index;
  MyText({super.key,required this.index});

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  int change(){
    setState(() {
    });
    return 88;
  }
  //第一次构建时使用map中的数据
  @override
  Widget build(BuildContext context) {
    String text = "";
    if(parametersStatus?[widget.index]==null){
      text = "0";
    }
    else{
      text = parametersStatus?[widget.index];
    }
    return Text(text);
  }
  
}