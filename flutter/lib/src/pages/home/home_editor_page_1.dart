import 'package:flutter/material.dart';
import 'package:kofoos/src/pages/home/home.dart';
import 'package:kofoos/src/pages/home/home_editor_page_2.dart';
import 'package:kofoos/src/root/root.dart';

class HomeEditorPage1 extends StatelessWidget {
  const HomeEditorPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              Text('신라면 - HomeEditorPage1'),
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
