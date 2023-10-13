import 'package:dio/dio.dart';
import '../settings.dart';

var q = Dio(BaseOptions(
  baseUrl: 'http://192.168.124.111:8080/',
  connectTimeout: 5000,
  receiveTimeout: 100000,
  contentType: Headers.jsonContentType,
  responseType: ResponseType.json,
));



//需要后端提供一个接口，用来获取全部的字段名称,数据类型是list
Future<List> getParameters()async{
  Response response = await q.get("/machine/initData/getParameters");
  if(response.data==null){
    return [];
  }
  return response.data["parameters"];
}

//根据主键id拉取当前硬件的全部状态和控制信息
Future<Map> getStatusById(String id) async {
  Map<String, dynamic> result;
  Response response = await q.get("/machine/info?$mainKey=$id");
  if(response.data==null){
    return {};
  }
  if(response.data["code"] is String) {
    if(response.data["code"].compareTo("200")!=0){
      return {};
    }
  }
  if(response.data["code"] is int){
    if(response.data["code"]!=200){
      return {};
    }
  }
  result = response.data["status"];
  return result;
}

//根据主键id和时间查询大于time时间的所有记录
Future<List> getStatusHistoryByDate(DateTime time,String id) async {
  List result = [];
  Response response = await q.get("/machineHistory/findByTime?$mainKey=$id&time=${time.millisecondsSinceEpoch}");
  if(response.data==null) {
    return [];
  }
  if(response.data["code"] is String) {
    if(response.data["code"].compareTo("200")!=0){
      return [];
    }
  }
  if(response.data["code"] is int){
    if(response.data["code"]!=200){
      return [];
    }
  }
  result = response.data["status"];
  return result;
}


//根据主键id和数量num查询最近的num条数据
Future<List> getStatusHistoryByNum(int num,String id) async{
  List result = [];
  Response response = await q.get("/machineHistory/findByNum?$mainKey=$id&num=$num");
  if(response.data==null){
    return [];
  }
  if(response.data["code"] is String) {
    if(response.data["code"].compareTo("200")!=0){
      return [];
    }
  }
  if(response.data["code"] is int){
    if(response.data["code"]!=200){
      return [];
    }
  }
  result = response.data["status"];
  return result;
}


//通过主键id往后端提交一个控制信息的修改
Future<bool> updateStatusById(Map<String, dynamic> json) async {
  Response response = await q.post("/machine/update", data: json);
  //返回值可能是字符串"200"或者数字200
  if (response.data["code"]==200){
    return true;
  }
  if (response.data["code"].compareTo("200")==0) {
    return true;
  }
  return false;
}
