import 'package:flutter/material.dart';

class HomeEditorPage2 extends StatelessWidget {
  const HomeEditorPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              Text('포테토칩 - HomeEditorPage2'),
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
