
import 'package:flutter/material.dart';
import 'myWidget/myText.dart';
import 'myWidget/mySwitch.dart';
import 'myWidget/mySliper.dart';
import 'routes/request_function.dart';

//服务器获取的所有字段的名称  -->list
List<dynamic> parameters=[];

//viewText是parameter在界面上的显示名称，需要与parameters的顺序一一对应，如果没有初始化就会默认显示parameters里的名字
List<String> viewText=[
  "主控ID",
  "室内温度",
  "室外温度",
  "灯光开关状态",
  "开灯阈值",
  "电压1",
  "电压2",
  "进店人数",
  "离店人数",
  "蜂鸣器开关状态",
  "更新时间"
];

Map ?parametersStatus={};

//是主键的索引，不是主键的值
String mainKey="";

/////////////////////////////////////////////////////////////////////////需要绘图的参数名称/////////////////////////////////////////////////////////
  List willTraverseParameter = [

  ];
////////////////////////////////////////////////////////////////////////绘图参数的中文/////////////////////////////////////////////////////////////////
  List textHHH = [

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
    bool result = await updateStatusById(json);
    return result;
  }  

Future<void> initData() async{
  //从服务器获取所有字段名称
  parameters = await getParameters();
  
  //设置主键，根据实际参数来
  mainKey = parameters[0];

  //先初始化TextKey
  initGlobalTextKey();

  //将parametersStatus初始化
  for(int i=0;i<parameters.length;i++){
    //尝试将参数名中带有 "switch" 或 "slider" 字符串的送入控制数组中，
    //但一般需要后端数据库的命名是规范的,
    //建议自行在这两个list中添加字段而不是通过我提供的这种方法
    if(parameters[i].contains("switch")){
      controlSwitchText.add(parameters[i]);
    }
    if(parameters[i].contains("slider")){
      controlSliderText.add(parameters[i]);
    }
 
    //绑定key和view中要刷新的字符串，需要先初始化GlobalKey
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
  //再初始化这两个Key，因为要用到controlSwitchText和controlSliderText，上面的for在对这两个list初始化
  initGlobalSliderKey();
  initGlobalSwitchKey();

  //设定switch按钮的基本设置和回调函数
  for(int i=0;i<controlSwitchText.length;i++){
    switchList.add(Text(controlSwitchText[i]));
    switchList.add(const SizedBox(width: 5));
    switchList.add(
      MySwitch(
        key: switchKey[controlSwitchText[i]],
        index: controlSwitchText[i],
        onChange: (flgg) async {
          Future<bool> flg = sendControllstate(controlSwitchText[i], flgg?"1":"0");
          //返回值为真，就更新本地数据并重新渲染Widget，否则什么都不干
          if(await flg){
            print("返回值为真");
            switchValue[controlSwitchText[i]] = flgg;
            parametersStatus?[controlSwitchText[i]] = flgg?"1":"0";
            switchKey[controlSwitchText[i]]!.currentState?.change();
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
        divisions: 100,
        max: 3000,
        min: 0,
        value: 0,
        index: controlSliderText[i],
        onChangeEnd: (p0) async{
          Future<bool> flg =  sendControllstate(controlSliderText[i], p0.toString());
          //返回值为真，就更新本地数据并重新渲染Widget，否则什么都不干
          if(await flg){
            sliderValue[controlSliderText[i]] = p0;
            parametersStatus?[controlSliderText[i]] = p0.toString();
            sliderKey[controlSliderText[i]]!.currentState?.change();
          }
        },
      )
    );
    sliderList.add(
      const SizedBox(height: 10)
    );
  }
  
}
