import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../dto/my_page_dto.dart';

class MyPageApi {
  Dio dio = Dio();
  final baseUrl = 'http://192.168.64.241:8080/api/users';

  // 마이페이지 정보 불러오기
  Future<MyPageDto> fetchMyPageInfo(int userId) async {
    final response = await dio.post(
      '$baseUrl/mypage',
      data: {
        'userId': userId,
      },
    );
    if (response.statusCode == 200) {
      print('마이페이지 가져오기 성공');
      return MyPageDto.fromJson(response.data);
    } else {
      print('마이페이지 가져오기 실패: ${response.statusCode}');
      throw Exception('Failed to load MyPage info');
    }
  }


  // 비선호 식재료 목록 업데이트
  Future<void> updateUserDislikedFoods(BuildContext context, int userId, List<int> dislikedFoodsIds) async {
    try {
      final response = await dio.post(
        '$baseUrl/update',
        data: {
          'userId': userId,
          'dislikedFoods': dislikedFoodsIds,
        },
      );
      if (response.statusCode == 200) {
        // 성공적으로 업데이트된 경우
        print('Disliked foods updated successfully');
      } else {
        // 에러 처리
        print('Failed to update disliked foods');
      }
    } catch (e) {
      print(e);
    }
  }

  // 사용자 언어 설정 업데이트
  Future<void> updateUserLanguage(BuildContext context, int userId, String language) async {
    try {
      final response = await dio.post(
        '$baseUrl/updateLanguage',
        data: {
          'userId': userId,
          'language': language,
        },
      );
      if (response.statusCode == 200) {
        // 성공적으로 업데이트된 경우
        print('User language updated successfully');
      } else {
        // 에러 처리
        print('Failed to update user language');
      }
    } catch (e) {
      print(e);
    }
  }
}
