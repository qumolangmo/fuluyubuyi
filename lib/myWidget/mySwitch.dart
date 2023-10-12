import 'package:flutter/material.dart';
import '../settings.dart';


Map<String,GlobalKey<_MySwitchState>> switchKey={};
Map<String,dynamic> switchValue={};   //每个按钮组件需要绑定一个外部value来作为按钮数值

void initGlobalSwitchKey(){           //根据你的控制参数中按钮属性的个数来生成全局Key
  for(int i=0;i<controlSwitchText.length;i++){
    GlobalKey<_MySwitchState> tmp = GlobalKey();
    switchKey[controlSwitchText[i]]=tmp;    //生成的key放入switchKey这个Map中
    switchValue[controlSwitchText[i]]=(parametersStatus?[controlSwitchText[i]]).compareTo("0")==0?false:true;    //根据获取到的数据更新值
  }
  
}

class MySwitch extends StatefulWidget {
  void Function(bool) onChange;
  String index;
  MySwitch({required this.index,required this.onChange,super.key});

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  void change(){
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: switchValue[widget.index],
      onChanged: widget.onChange,
    );
  }
}