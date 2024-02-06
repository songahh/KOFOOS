import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../root/root.dart';
import '../../home/home.dart';
import '../func/show_consent_dialog.dart';
import '../select_food.dart';

// Dio 인스턴스 생성
final Dio dio = Dio();

//회원 등록 api
Future<void> registerUser(BuildContext context, String deviceId, String language) async {
  var url = 'http://192.168.64.241:8080/api/users/register';
  try {
    var response = await dio.post(
      url,
      data: {
        'deviceId': deviceId,
        'language': language,
      },
    );
    if (response.statusCode == 200) {
      print('User registered successfully');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FoodSelectionPage()),
      );
    } else {
      print('Failed to register user');
    }
  } catch (e) {
    print(e.toString());
  }
}

//사용자 등록 여부 확인 및 화면 이동 로직
Future<void> checkUserRegistration(BuildContext context, String deviceId) async {
  var url = 'http://192.168.64.241:8080/api/users/check-registration/$deviceId';
  try {
    var response = await dio.get(url);
    if (response.statusCode == 200) {
      var isRegistered = response.data;
      if (isRegistered) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Root()),
        );
      } else {
        showConsentDialog(context);
      }
    } else {
      print('Failed to check user registration');
    }
  } catch (e) {
    print(e.toString());
  }
}





// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '../../home/home.dart';
// import '../func/show_consent_dialog.dart';
// import '../select_food.dart'; // 다음으로 이동할 페이지의 경로
//
//
//
// //사용자 등록 여부 확인 및 화면 이동 로직
// Future<void> checkUserRegistration(BuildContext context,String deviceId) async {
//   var url = Uri.parse('http://172.30.1.58:8080/api/users/check-registration/$deviceId');
//   try {
//     var response = await http.get(url);
//     if (response.statusCode == 200) {
//       var isRegistered = json.decode(response.body);
//       if (isRegistered) {
//         // 이미 등록된 사용자이면 홈 화면으로 이동
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Home()), // 홈으로 이동
//         );
//       } else {
//         // 등록되지 않은 사용자이면 동의 팝업 표시
//         showConsentDialog(context);
//       }
//     } else {
//       // 요청 실패 처리
//       print('Failed to check user registration');
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }
//
// //회원 등록 api
// Future<void> registerUser(BuildContext context, String deviceId, String language) async {
//   var url = Uri.parse('http://172.30.1.58:8080/api/users/register');
//   var response = await http.post(
//     url,
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({
//       'deviceId': deviceId,
//       'language': language,
//     }),
//   );
//
//   if (response.statusCode == 200) {
//     print('User registered successfully');
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => const FoodSelectionPage()), // 가입 됐으면 비선호 음식 선택 페이지로
//     );
//   } else {
//     print('Failed to register user');
//   }
// }
