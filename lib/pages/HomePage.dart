import 'package:flutter/material.dart';

import '../myWidget/mySliper.dart';
import '../myWidget/mySwitch.dart';
import '../myWidget/myText.dart';

import '../pages/Count.dart';
import '../pages/Search.dart';
import '../pages/Home.dart';
import '../routes/request_function.dart';
import '../settings.dart';

import "dart:async";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex=0;
  List<Widget> list=[
    Home(),
    Search(),
    Count(),
  ];
  
  @override
  void initState(){
    
    super.initState();
    ////////////////////////设置程序启动后，定时向服务器获取状态信息///////////////////////
    Timer.periodic(const Duration(seconds: 2), (timer) async{
        Map result = await getStatusById(parametersStatus?[mainKey]);
        setState(() {
          //////////////////////将服务器获取到的数据复制到parametersStatus中///////////////////////////
          parametersStatus = result;
          //////////////////////根据要刷新状态的widget的ID值来更改其状态//////////////////////////
          for(int i=0;i<textKey.length;i++){
            textKey[parameters[i]].currentState?.change();
          }
          
          for(int i=0;i<switchKey.length;i++){
            switchKey[controlSwitchText[i]].currentState?.change();
          }
          for(int i=0;i<sliderKey.length;i++){
            sliderKey[controlSliderText[i]].currentState?.change();
          }
        });
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("智能外骨骼监控"),
        actions: [
          ////////////////////////文本输入框///////////////////////   
            Align(alignment: Alignment.center,
              child: SizedBox(
              width: 160,
              child: TextField(
                maxLines: 1,
                onSubmitted: (value) {
                  parametersStatus?[mainKey] = value;
                  setState(() {
                    textKey[mainKey].currentState?.change();
                  });
                },
                decoration: const InputDecoration(
                  isCollapsed: true,        //允许设置行高
                  contentPadding: EdgeInsets.only(top: 8,bottom: 8,left: 8),
                  filled: true,              //允许填充背景颜色
                  fillColor: Color.fromARGB(255, 248, 248, 248),
                  border: OutlineInputBorder(),
                  hintText: '  请输入ID',
                ),
              ),
            ),),
            const SizedBox(width: 30,),
        ],
      ),
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "首页"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "查询"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cut_outlined),
            label: "统计"
          ),
        ],
      ),
    );
  }
}

