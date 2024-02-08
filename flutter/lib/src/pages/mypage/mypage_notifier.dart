// my_page_notifier.dart
import 'package:flutter/material.dart';
import 'dto/my_page_dto.dart';
import 'api/mypage_api.dart';


//상태 변경 반영용
class MyPageNotifier with ChangeNotifier {
  MyPageDto? myPageInfo;
  final MyPageApi _api = MyPageApi();

  MyPageNotifier() {
    fetchMyPageInfo(14); // 유저 ID는 동적으로 설정해야 함
  }

  void fetchMyPageInfo(int userId) async
    try {
      myPageInfo = await _api.fetchMyPageInfo(userId);
      notifyListeners();
    } catch (e) {
      // 에러 처리
      print(e);
    }
  }

// 기타 상태 변경 함수들...
}
