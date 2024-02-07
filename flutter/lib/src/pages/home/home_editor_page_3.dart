import 'package:flutter/material.dart';
import 'package:kofoos/src/common/back_button_widget.dart';

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
          BackButtonWidget(),
        ],
      ),
    );
  }
}
