import 'package:flutter/material.dart';
import '../routes/request_function.dart';
import '../settings.dart';

import '../myWidget/mySliper.dart';
import '../myWidget/mySwitch.dart';
import '../myWidget/myText.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //刷新按钮按下后的回调函数
  void _refresh() async {
    Map result = await getStatusById(parametersStatus?[mainKey]);
    setState(() {
      parametersStatus = result;
      for(int i=0;i<textKey.length;i++){
        textKey[parameters[i]]!.currentState?.change();
      }
      for(int i=0;i<switchKey.length;i++){
        switchKey[controlSwitchText[i]]!.currentState?.change();
      }
      for(int i=0;i<sliderKey.length;i++){
        sliderKey[controlSliderText[i]]!.currentState?.change();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: [
          /////////////////第一行卡片显示物联网设备的所有状态信息////////////////////
          Expanded(
              flex: 5,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 9,
                    child: Card(                              //文本状态的容器组件
                      elevation: 16,
                      margin: const EdgeInsets.all(20),       //设置外边距
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),  //设置阴影
                      ),
                      child: ListView.builder(                //根据文本list中的数据生成一个ListView，当数据库中数据更改时也会同步更改
                          itemCount: titleList.length,
                          itemBuilder: ((context, index) {
                            return titleList[index];
                          })),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Card(                            //刷新按钮的容器组件
                        elevation: 16,
                        margin: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 20),  //设置外边距
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),    //设置阴影
                        ),
                        child: Center(
                          child: IconButton(                  //一个居于水平和垂直中心的图标按钮，按钮的回调函数是_refresh，用来请求物联网设备的状态信息
                              onPressed: _refresh, icon: const Icon(Icons.refresh)),
                        ),
                      )),
                ],
              )),

          /////////////////////////////////第二行是自行车控件//////////////////////////////////////////////
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.all(20),                 //设置外边距
              padding: const EdgeInsets.all(15),                //设置内边距
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 244, 244),      //设置Container容器的背景颜色
                  borderRadius: BorderRadius.circular(20),                //设置圆角边框
                  boxShadow: const [
                    BoxShadow(                                            //设置阴影
                        color: Color.fromARGB(255, 193, 193, 193),
                        blurRadius: 5),
                  ]),
              ////////////////这里写控件/////////////////////
              child: Column(
                children: [
                  ////////////////////////////////////////////ListView组件的父组件必须是有固定宽(或高)的组件，可以指定固定高度或者使用flex///////////////////
                  SizedBox(
                    height: 150,
                    child: 
                      //Row(
                        //mainAxisSize: MainAxisSize.min,
                        //children: [
                          ////////////////////////switch按钮///////////////////////
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap:true,
                            itemCount: switchList.length,                       //switchList是 按钮组件的list
                            itemBuilder: (context, index) {
                              return switchList[index];
                            },
                          ),
                        //],
                      //),
                  ),
                  
                                
                  ////////////////////slider滑块///////////////////////////             
                  SizedBox(
                    height: 150,
                    child: 
                      //Row(
                        //mainAxisSize: MainAxisSize.min,
                        //children: [
                          ListView.builder(
                            shrinkWrap:true,
                            itemCount: sliderList.length,                         //sliderList 是滑块组件的list
                            itemBuilder: ((context, index) {
                              return sliderList[index];
                            })
                          )
                        //]
                      //),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
