import 'package:flutter/material.dart';

class HomeEditorPage3 extends StatelessWidget {
  const HomeEditorPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text('먹태깡 - HomeEditorPage3'),
                Container(
                  child: Image.asset('assets/editor/e2.jpg'),
                ),
                Container(
                  child: Image.asset('assets/editor/e2.jpg'),
                ),
                Container(
                  child: Image.asset('assets/editor/e2.jpg'),
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
