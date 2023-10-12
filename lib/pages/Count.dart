import 'package:flutter/material.dart';
import '../routes/request_function.dart';
import '../myWidget/myFLChart.dart';
import '../settings.dart';

double getMax(List<List> tmp){
  List max = [0,0.0];
  for(var ttt in tmp){
    if(ttt[1]>max[1]){
      max = ttt;
    }
  }
  return max[1];
}

double getMin(List<List> tmp){
  List min = [0,0.0];
  for(var ttt in tmp){
    if(ttt[1]<min[1]){
      min = ttt;
    }
  }
  return min[1];
}

class Count extends StatefulWidget {
  const Count({super.key});

  @override
  State<Count> createState() => _CountState();
}



class _CountState extends State<Count> {
  //存放从服务器获取的数据map
  List resultList = [];
  //存放所有图标的绘图数据
  List<List<List>> finallyData = [];
  
  List chartWidget = [];

  int selectNum = 10;
  int groupValue = 0;
  String year = "";
  String month = "";
  String day = "";
  String hour = "";
  String minute = "";
  String second = "";
  int count = 0;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    DateTime date = DateTime.now();
    year = "${date.year}";
    month = "${date.month}";
    day = "${date.day}";
    hour = "${date.hour}";
    minute = "${date.minute}";
    second = "01";

    ////////////////////////设置程序启动后，定时向服务器获取状态信息///////////////////////
    

  }

  void refresh() async {
    if (month.length == 1) {
      month = "0$month";
    }
    if (day.length == 1) {
      day = "0$day";
    }
    if (hour.length == 1) {
      hour = "0$hour";
    }
    if (second.length == 1) {
      second = "0$second";
    }
    if (groupValue == 0) {
      resultList = await getStatusHistoryByNum(selectNum, parametersStatus?[mainKey]);
    } 
    else {
      resultList = await getStatusHistoryByDate(
          "$year-$month-$day $hour:$minute:01", parametersStatus?[mainKey]);
    }

    //重置待渲染图标的List
    finallyData.length = 0;
    chartWidget.length = 0;

    int flaggggg = 1;
    for (var param in willTraverseParameter) {
      //遍历获取结果集中的param变量对应的数据并放入制表list中
      List<List> list = [];
      int i=1;
      for (var tmp in resultList) {
        list.add([i++,double.parse(tmp[param])]);
      }
      finallyData.add(list);
    }
    
    //外骨骼项目中此处finallData长度应为3
    for (int i = 0; i < finallyData.length; i++) {
      chartWidget.add(Text(textHHH[i]));
      chartWidget.add(SizedBox(
        height: 500,
        width: 400,
        child: MyFLChart(
          data: finallyData[i],
          maxX: selectNum.toDouble(),
          minX: 1.0,
          maxY: getMax(finallyData[i]),
          minY: getMin(finallyData[i]),
        )
      ));
    }
    //绘图测试数据
    // chartWidget.add(
    //   SizedBox(
    //     height: 500,
    //     width: 400,
    //     child: MyFLChart(
    //       key: flChartKey,
    //       data: [[0,Random().nextInt(25)+26],[1,Random().nextInt(25)+26],[2,Random().nextInt(25)+26],[3,Random().nextInt(25)+26],[4,Random().nextInt(25)+26],[5,Random().nextInt(25)+26],[6,Random().nextInt(25)+26]],
    //       maxX: 6,
    //       minX: 0,
    //       maxY: 51,
    //       minY: 26
    //     ),
    //   ),
    // );
    setState(() {
      //每refresh一次就调整chartWidget长度，以便listView能检测到改动后调用build方法
      if (flaggggg == 1) {
        chartWidget.add(const SizedBox(
          height: 1,
        ));
        flaggggg = 0;
      } else {
        chartWidget.add(const SizedBox(
          height: 1,
        ));
        chartWidget.add(const SizedBox(
          height: 1,
        ));
        flaggggg = 1;
      }
    });

    flChartKey.currentState?.change();
  }

  void selectByNum(int? num) {
    setState(() {
      groupValue = num!;
    });
  }

  void selectByTime(int? num) {
    setState(() {
      groupValue = num!;
    });
  }

  void outDatePicker() async {
    var resultPicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    setState(() {
      year = "${resultPicker?.year}";
      month = "${resultPicker?.month}";
      day = "${resultPicker?.day}";
    });
  }

  void outTimePicker() async {
    var resultPicker = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input);

    setState(() {
      hour = "${resultPicker?.hour}";
      minute = "${resultPicker?.minute}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Radio(
                        value: 0,
                        groupValue: groupValue,
                        onChanged: selectByNum),
                    const Text("按条查询最近的记录"),
                    const SizedBox(
                      width: 10,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 160,
                          child: TextField(
                            maxLines: 1,
                            onSubmitted: (value) {
                              setState(() {
                                selectNum = int.parse(value);
                              });
                            },
                            decoration: const InputDecoration(
                              isCollapsed: true, //允许设置行高
                              contentPadding:
                                  EdgeInsets.only(top: 8, bottom: 8, left: 8),
                              filled: true, //允许填充背景颜色
                              fillColor: Color.fromARGB(255, 248, 248, 248),
                              border: OutlineInputBorder(),
                              hintText: '  这里输入记录条数',
                            ),
                          ),
                        ))
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Radio(
                        value: 1,
                        groupValue: groupValue,
                        onChanged: selectByTime),
                    const Text("按时间查询最近的记录"),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: outDatePicker,
                      child: Text('$year-$month-$day'),
                    ),
                    ElevatedButton(
                      onPressed: outTimePicker,
                      child: Text('$hour:$minute:$second'),
                    ),
                  ],
                ),
                Center(
                  child: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: refresh,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Center(
                child: ListView.builder(
                  itemCount: chartWidget.length,
                  itemBuilder: (context, index) {
                    return chartWidget[index];
                  },
                )
            ),
          )
        ],
      ),
    );
  }
}
