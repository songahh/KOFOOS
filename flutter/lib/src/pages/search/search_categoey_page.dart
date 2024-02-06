import 'package:flutter/material.dart';

class SearchCategoryPage extends StatelessWidget {
  const SearchCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Text('카테고리검색'),
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
