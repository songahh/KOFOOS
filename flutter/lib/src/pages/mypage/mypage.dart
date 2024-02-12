import 'package:flutter/material.dart';
import 'package:kofoos/src/pages/mypage/func/users_delete_func.dart';
import 'package:kofoos/src/pages/mypage/func/users_update_lang_func.dart';


class Mypage extends StatelessWidget {
  const Mypage({Key? key}) : super(key: key);

  Widget _myPageWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 70,
            color: Color(0xff343F56),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 32,
                  ),
                  Text(
                    ' My page',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      // 유저 회원탈퇴 api
                      usersDeleteFunc(context);
                    },
                    child: Text(
                      'Delete Account',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.grey,
                        decorationThickness: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20.0,
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Text(
                  '   Language',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // 언어 변경 함수
                    usersUpdateLangFunc(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffECECEC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    child: Text(
                      '선택한 언어', // 유저가 선택한 언어 출력
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
              ],
            ),
          ),
          Container(
            height: 20.0,
            color: Colors.white,
          ),
          Divider(
            color: Color(0xffECECEC),
            height: 2.0,
            thickness: 2.0,
          ),
          Container(
            height: 20.0,
            color: Colors.white,
          ),
          Container(
            color: Color(0xffFFFFFF),
            child: Row(
              children: [
                Text(
                  '   Disliked Foods',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    // 비선호 식품 조회 api
                    print('알러지 선택창으로 이동');
                  },
                  child: Text(
                    'More details',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.grey,
                      decorationThickness: 2.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 12.0,
                ),
              ],
            ),
          ),
          Container(
              color: Color(0xffFFFFFF),
              child: Container(
                height: 150,
                child: Text('비선호 식품 보여줄 컨테이너'),
              )),
          Container(
            height: 20.0,
            color: Colors.white,
          ),
          Divider(
            color: Color(0xffECECEC),
            height: 2.0,
            thickness: 2.0,
          ),
          Container(
            height: 20.0,
            color: Colors.white,
          ),
          Container(
            color: Color(0xffFFFFFF),
            child: Row(
              children: [
                Text(
                  '   History',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            color: Color(0xffFFFFFF),
            child: Container(
              height: 150,
              child: Text('히스토리 보여줄 컨테이너'),
            ),
          ),
          Container(
            height: 40.0,
            color: Colors.white,
          ),
          Container(
            height: 100.0,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xffECECEC), // 배경색 지정
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'KOFOOS\nSeoul, Korea\nContact kofoos@gmail.com',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffCACACA)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _myPageWidget(context),
    );
  }
}
