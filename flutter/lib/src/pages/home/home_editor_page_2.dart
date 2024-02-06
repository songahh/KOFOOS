import 'package:flutter/material.dart';

class HomeEditorPage2 extends StatelessWidget {
  const HomeEditorPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text('포테토칩 - HomeEditorPage2'),
                Container(
                  child: Image.asset('assets/editor/e1.jpg'),
                ),
                Container(
                  child: Image.asset('assets/editor/e1.jpg'),
                ),
                Container(
                  child: Image.asset('assets/editor/e1.jpg'),
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
