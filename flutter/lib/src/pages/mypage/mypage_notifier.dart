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

  void fetchMyPageInfo(int userId) async {
    try {
      myPageInfo = await _api.fetchMyPageInfo(userId);
      print('데이터 로드 성공: $myPageInfo'); // 성공적으로 데이터 로드 시 콘솔에 출력
      notifyListeners();
    } catch (e) {
      // 에러 처리
      print('데이터 로드 실패: $e'); // 데이터 로드 실패 시 에러 메시지 출력
    }
  }

// 기타 상태 변경 함수들...
}
