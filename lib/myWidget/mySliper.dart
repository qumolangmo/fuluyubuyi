import 'package:fuluyubuyi/settings.dart';
import 'package:flutter/material.dart';


Map<String,dynamic> sliderKey={};
Map<String,dynamic> sliderValue={};       //每个滑块组件需要绑定一个外部value来作为滑块数值

void initGlobalSliderKey(){           //根据你的控制参数中滑块属性的个数来生成全局Key
  for(int i=0;i<controlSliderText.length;i++){
    GlobalKey<_MySliderState> tmp = GlobalKey();
    sliderKey[controlSliderText[i]]=tmp;      //生成的key放入sliderKey这个Map中
    sliderValue[controlSliderText[i]]=0;      //默认所有的滑块组件的初始值为0
  }
}

class MySlider extends StatefulWidget {
  late final int divisions;
  final String index;
  final double max;
  final double min;
  late final double value;
  void Function(double)? onChangeEnd;
  MySlider({required this.value,required this.index,super.key, required this.max, required this.min,required this.onChangeEnd, required this.divisions});
  

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {

  void change(){
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
      
      return Slider(
        value: sliderValue[widget.index].toDouble(),
        onChanged: (data) {
          setState(() {
            sliderValue[widget.index] = data;
          });
        },
        divisions: widget.divisions,
        min: widget.min,
        max: widget.max,
        onChangeEnd: widget.onChangeEnd,
        label: '${sliderValue[widget.index]}'
      );
  }
}