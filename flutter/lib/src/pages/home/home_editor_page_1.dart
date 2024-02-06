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
          SingleChildScrollView(
            child: Column(
              children: [
                Text('신라면 - HomeEditorPage1'),
                Container(
                  child: Image.asset('assets/editor/e0.jpg'),
                ),
                Container(
                  child: Image.asset('assets/editor/e0.jpg'),
                ),
                Container(
                  child: Image.asset('assets/editor/e0.jpg'),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0, right: 30.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back),
                backgroundColor: Color(0xffECECEC),
                foregroundColor: Color(0xff343F56),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
