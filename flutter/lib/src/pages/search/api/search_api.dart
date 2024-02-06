import 'dart:io';

import 'package:dio/dio.dart';

class SearchApi {
  var searchDio = Dio(
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

  Future<List<String>> getRanking() async {
    try {
    var response = await searchDio.get('/products/category/ranking');
      List<String> ranking = List<String>.from(response.data);
      return ranking;
    } catch (e) {
      throw Exception('getRanking error: $e');
    }
  }
}
