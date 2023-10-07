// import 'package:flutter/material.dart';
// import 'package:fuluyubuyi/pages/Home.dart';
// import 'package:fuluyubuyi/routes/bike.dart';

// GlobalKey<_MyIconButtonState> buttonKeywaterState = GlobalKey();
// GlobalKey<_MyIconButtonState> buttonKeyLeft = GlobalKey();
// GlobalKey<_MyIconButtonState> buttonKeyRight = GlobalKey();
// GlobalKey<_MyIconButtonState> buttonKeyBuzzer = GlobalKey();
// GlobalKey<_MyIconButtonState> buttonKeyRent = GlobalKey();

// List<GlobalKey<_MyIconButtonState>> buttonKey = [];

// void initGlobalButtonKey(){
  
// }

// class MyIconButton extends StatefulWidget {
//   void Function() onPressed;
//   Icon icon;
//   Color color;
//   String index;
//   MyIconButton({required this.index,required this.color,required this.icon,required this.onPressed,super.key});

//   @override
//   State<MyIconButton> createState() => _MyIconButtonState();
// }

// class _MyIconButtonState extends State<MyIconButton> {
//   void change(){
//     setState(() {
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     // if(widget.index==textMapping[2]){
//     //   return IconButton(
//     //   onPressed: widget.onPressed, 
//     //   icon: waterStatue?[widget.index]=="1"?const Icon(Icons.lock_open): const Icon(Icons.lock_outline),
//     //   color: waterStatue?[widget.index]=="1"?Colors.blue:Colors.black,
//     //   iconSize: 40,
//     // );
//     // }
//     return IconButton(
//       onPressed: widget.onPressed, 
//       icon: widget.icon,
//       color: waterStatue?[widget.index]=="2"?Colors.green:waterStatue?[widget.index]=="1"?Colors.red:Colors.black,
//       iconSize: 40,
//     );
//   }
// }