
import 'package:flutter/material.dart';
import 'myWidget/myText.dart';
import 'myWidget/mySwitch.dart';
import 'myWidget/mySliper.dart';
import 'routes/request_function.dart';

//服务器获取的所有字段的名称list
List<dynamic> parameters=[];

//viewText是parameter在界面上的显示名称，需要与parameters的顺序一一对应，如果没有初始化就会默认显示parameters里的名字
List<String> viewText=[
  "设备id",
  "脑电波信号",
  "专注度信号",
  "放松度信号",
  "弯曲角度",
  "肌肉电信号",
  "姿态角roll数据",
  "姿态角pitch数据",
  "姿态角yaw数据",
  "更新日期",
  "更新时间",
];

Map ?parametersStatus={};

//是主键的索引，不是主键的值
String mainKey="";

/////////////////////////////////////////////////////////////////////////需要绘图的参数名称/////////////////////////////////////////////////////////
  List willTraverseParameter = [
    "signalEeg",
    "signalFocus",
    "signalRelax"
  ];
////////////////////////////////////////////////////////////////////////绘图参数的中文/////////////////////////////////////////////////////////////////
  List textHHH = [
    "脑电波信号",
    "专注度信号",
    "放松度信号"
  ];

//服务器返回数据中要作为按钮的参数名  
//控制参数中 取值范围只有0和1 建议作为按钮
//强烈建议手动定义,然后在initData的第一个for循环中注释掉第一个if！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
List<String> controlSwitchText=[
  
];

//服务器返回数据中要作为滑块的参数名
//控制参数中 取值范围是连续的区间 建议作为滑块
//强烈建议手动定义,然后在initData的第一个for循环中注释掉第2个if！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
List<String> controlSliderText=[
  "signal_focus",
  "quality_waves"
];

List<ListTile> titleList=[

];
List<dynamic> switchList=[
  
];

//这里墙裂建议手动定义，然后在initData中注释掉最后一个for循环！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
List<dynamic> sliderList=[
  
];

Future<bool> sendControllstate(String index,String state)async{
    Map<String, dynamic> json ={
          mainKey: parametersStatus?[mainKey],
          index: state,
        };
    var result = await updateStatusById(int.parse(parametersStatus?[mainKey]), json);
    return result;
  }  

void initData() async{
  //从服务器获取所有字段名称
  parameters = await getParameters();
  
  //设置主键，根据实际参数来
  mainKey = parameters[0];

  //初始化全部的Key
  initGlobalSliderKey();
  initGlobalSwitchKey();
  initGlobalTextKey();

  //将parametersStatus初始化
  for(int i=0;i<parameters.length;i++){
    //尝试将参数名中带有 "Switch" 或 "Slider" 字符串的送入控制数组中，
    //但一般需要后端返回值的命名规范,
    //建议自行在这两个list中添加字段而不是通过我提供的这种方法
    if(parameters[i].contains("Switch")){
      controlSwitchText.add(parameters[i]);
    }
    if(parameters[i].contains("Slider")){
      controlSliderText.add(parameters[i]);
    }

    //初始化状态map
    parametersStatus![parameters[i]] = "0";
 
    //绑定key和view中要刷新的字符串
    titleList.add(
      ListTile(
        trailing: MyText(
          key: textKey[parameters[i]],
          index: parameters[i]          
        ),
        minLeadingWidth: 40,
        title: viewText.isEmpty?Text(parameters[i]):Text(viewText[i]),      //判断viewText是否为空，为空就显示parameters数组中的名称
      )
    );
  }


  //设定switch按钮的基本设置和回调函数
  for(int i=0;i<controlSwitchText.length;i++){
    switchList.add(Text(controlSwitchText[i]));
    switchList.add(const SizedBox(width: 5));
    switchList.add(
      MySwitch(
        key: switchKey[controlSwitchText[i]],
        index: controlSwitchText[i],
        onChange: (flgg) async {
          switchValue[controlSwitchText[i]] = flgg;
          Future<bool> flg = sendControllstate(controlSwitchText[i], flgg==true?"1":"0");
          if(await flg){
            parametersStatus?[controlSwitchText[i]] = flgg==true?"1":"0";
            switchKey[controlSwitchText[i]].currentState?.change();
          }
          else{
            parametersStatus?[controlSwitchText[i]] = flgg==true?"1":"0";
            switchKey[controlSwitchText[i]].currentState?.change();
          }
        }
      )
    );
    switchList.add(const SizedBox(width: 5));
  }

  //设定slider滑块的基本设置和回调函数
  for(int i=0;i<controlSliderText.length;i++){
    sliderList.add(Text(controlSliderText[i]));
    sliderList.add(
      const SizedBox(height: 10)
    );
    sliderList.add(
      MySlider(
        key: sliderKey[controlSliderText[i]],
        divisions: 1,
        max: 100,
        min: 0,
        value: 0,
        index: controlSliderText[i],
        onChangeEnd: (p0) async{
          sliderValue[controlSliderText[i]] = p0;
          Future<bool> flg =  sendControllstate(controlSliderText[i], p0.toString());
          if(await flg){
            parametersStatus?[controlSliderText[i]] = p0.toString();
            sliderKey[controlSliderText[i]].currentState?.change();
          }
          else{
            parametersStatus?[controlSliderText[i]] = p0.toString();
            sliderKey[controlSliderText[i]].currentState?.change();
          }
        },
      )
    );
    sliderList.add(
      const SizedBox(height: 10)
    );
  }

}
