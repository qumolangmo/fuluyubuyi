import 'package:flutter/material.dart';
import 'package:fuluyubuyi/routes/request_function.dart';
import '../routes/routes.dart';
import 'settings.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main()async{
  //WidgetsBinding widgetsFlutterBinding =  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsFlutterBinding);
  //FlutterNativeSplash.remove();
  runApp(MyApp());
  //在启动的瞬间就开始请求数据
  await Future.delayed(Duration.zero,()async{
      initData();
      parametersStatus = await getStatusById("100000000001");
    }  
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}