import 'package:dio/dio.dart';


var q = Dio(BaseOptions(
  baseUrl: 'http://192.168.95.67:8032/',
  connectTimeout: 5000,
  receiveTimeout: 100000,
  contentType: Headers.jsonContentType,
  responseType: ResponseType.json,
));

//需要后端提供一个接口，用来获取全部的字段名称,数据类型是list
Future<List> getParameters()async{
  Response response = await q.get("/machine/initData/getParameters");
  response.data["parameters"];
  if(response.data["parameters"]==null){
    throw "没有从服务器获取到初始化参数，无法继续"; 
  }
  return response.data["parameters"];
}

//根据主键id拉取当前硬件的全部状态和控制信息
Future<Map> getStatusById(String id) async {
  Map<String, dynamic> result;
  Response response = await q.get("/machine/info?sensor_id=$id");
  if(response.data==null) {
    return {};
  }
  result = response.data["status"];
  return result;
}

//根据主键id和时间查询大于time时间的所有记录
Future<List> getStatusHistoryByDate(String time,String id) async {
  List result = [];
  Response response = await q.get("/machineHistory/list/time/?sensor_id=$id&time=$time");
  result = response.data["time"] as List;
  return result;
}

//根据主键id和 时间区间 查询在这个区间内的全部记录
Future<List> getStatusHistoryByInterval(String time1,String time2,String id)async{
  List result = [];
  Response response = await q.get("/machineHistory/findField/field?sensor_id=$id&startTime=$time1&endTime=$time2");
  result = response.data["field"] as List;
  return result;
}

//根据主键id和数量num查询最近的num条数据
Future<List> getStatusHistoryByNum(int num,String id) async{
  List result = [];
  Response response = await q.get("/machineHistory/list/nums?sensor_id=$id&num=$num");
  if(response.data==null||response.data["page"]==null){
    return [];
  }
  result = response.data["page"] as List;
  return result;
}


//通过主键id往后端提交一个控制信息的修改
Future<bool> updateStatusById(int id, Map<String, dynamic> json) async {
  Response response = await q.post("/machine/update/", data: json);
  if (response.data["code"] == 200) {
    return true;
  }
  return false;
}
