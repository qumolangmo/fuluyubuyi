import 'package:flutter/material.dart';
import '../routes/request_function.dart';
import '../myWidget/myText.dart';
import '../settings.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<ListTile> listResult = [];
  int selectNum = 10;
  int groupValue = 0;
  String year = "";
  String month = "";
  String day = "";
  String hour = "";
  String minute = "";
  String second = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime date = DateTime.now();
    year = "${date.year}";
    month = "${date.month}";
    day = "${date.day}";
    hour = "${date.hour}";
    minute = "${date.minute}";
    second = "01";
  }
  String characterConversion(String sst) {    //更改输出格式
    String up;
    up = sst;
    sst = "";
    for (int i = 0; i < up.length; i++) {
      if (up[i] == '{' || up[i] == '}')
        sst += up[i] + '\n';
      else if (up[i] == ',')
        sst += up[i] + '\n';
      else
        sst += up[i];
    }
    return sst;
  }
  void refresh() async {
    if(month.length==1){
      month = "0$month";
    }
    if(day.length==1){
      day = "0$day";
    }
    if(hour.length==1){
      hour = "0$hour";
    }
    if(second.length==1){
      second = "0$second";
    }
    var resultList = [];
    if (groupValue == 0) {
      resultList = await getStatusHistoryByNum(selectNum,parametersStatus?[mainKey]);
    } else {
      resultList = await getStatusHistoryByDate(
          "$year-$month-$day $hour:$minute:01",parametersStatus?[mainKey]);
    }
    setState(() {
      listResult.length=0;
      for(int i=0;i<resultList.length;i++){
        //Widget        Map
        listResult.add(ListTile(
          title: Text(characterConversion("第${i+1}条${resultList[i]}")),
        ));
      }
    });
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
      firstDate: DateTime(2023),
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
              flex: 2,
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
                          onChanged: selectByNum
                      ),
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
                  )
                ],
              )),
          Expanded(
            flex: 7,
            child: ListView.builder(
              itemCount: listResult.length,
              itemBuilder: (context,index){
                return listResult[index];
              }
              )
          )
        ],
      ),
    );
  }
}
