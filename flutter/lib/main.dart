import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kofoos/src/common/device_controller.dart';
import 'package:kofoos/src/pages/register/register.dart';
import 'package:kofoos/src/root/root_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KOFOOS',
      initialBinding: BindingsBuilder(() {
        Get.put(DeviceController());
        Get.put(RootController());
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: StartApp(), //Root(), StartApp()으로 변경하여 앱 시작점을 변경할 수 있습니다.

    );
  }
}
