import 'dart:io';

import 'package:dio/dio.dart';

class HomeApi {
  var homeDio = Dio(
    BaseOptions(
      baseUrl: "http://i10a309.p.ssafy.io:8080",
      connectTimeout: 5000,
      receiveTimeout: 5000,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json'
      },
    ),
  );

  // 데이
  Future<List<String>> getRanking(int barcode) async {
    try {
      var response = await homeDio.get('/detail/$barcode');
      List<String> ranking = List<String>.from(response.data);
      return ranking;
    } catch (e) {
      throw Exception('getRanking error: $e');
    }
  }

}
