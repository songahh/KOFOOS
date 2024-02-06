import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void usersUpdateLangAPI(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text('Select Language'),
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              print('영어 선택 로직 추가(유저 언어 업데이트)');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('中文'),
            onTap: () {
              print('중국어 선택 로직 추가(유저 언어 업데이트)');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('日本語'),
            onTap: () {
              print('일본어 선택 로직 추가(유저 언어 업데이트)');
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
