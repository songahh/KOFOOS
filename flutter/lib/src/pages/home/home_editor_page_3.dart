import 'package:flutter/material.dart';

class HomeEditorPage3 extends StatelessWidget {
  const HomeEditorPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              Text('먹태깡 - HomeEditorPage3'),
            ],
          ),
          Positioned(
            bottom: 30.0, // 조절 가능
            right: 30.0, // 조절 가능
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
              backgroundColor: Color(0xffECECEC),
              foregroundColor: Color(0xff343F56),
            ),
          ),
        ],
      ),
    );
  }
}
