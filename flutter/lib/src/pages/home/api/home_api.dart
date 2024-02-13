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

  Future<List<String>> getRanking(int barcode) async {
    try {
      var response = await homeDio.get('/detail/$barcode');
      List<String> ranking = List<String>.from(response.data);
      return ranking;
    } catch (e) {
      throw Exception('getRanking error: $e');
    }
  }

  Future<List<dynamic>> getRecommendHot() async {
    try {
      var response = await homeDio.get('/recommend/hot');
      List<dynamic> recommendHotList = response.data;
      return recommendHotList;
    } catch (e) {
      throw Exception('getRecommendHot error: $e');
    }
  }

  Future<List<dynamic>> getRecommendHistory() async {
    try {
      var response = await homeDio.post(
        '/recommend/history',
        // deviceId 수정 필요
        data: {'deviceId': 'rayeon'},
      );
      List<dynamic> recommendHistoryList = response.data;
      return recommendHistoryList;
    } catch (e) {
      throw Exception('getRecommendHot error: $e');
    }
  }
}
