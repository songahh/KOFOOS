import 'package:flutter/material.dart';

void usersDeleteAPI(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete account'),
        content: Text('Are you sure you want to delete your account?'),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black, // 버튼의 텍스트 색상
            ),
            onPressed: () {
              Navigator.of(context).pop(); // 창 닫기
            },
            child: Text('Keep Account'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.black, // 버튼의 텍스트 색상
            ),
            onPressed: () {
              print('유저 회원 탈퇴 로직 추가');
              Navigator.pop(context);
            },
            child: Text('Yes, Delete'),
          ),
        ],
      );
    },
  );
}
