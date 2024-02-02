import 'package:flutter/material.dart';
import 'package:kofoos/src/root/root_controller.dart';
import 'package:kofoos/src/pages/home/home_editor_page_1.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  Widget _wishlistWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Color(0xff343F56),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  ' Wishlist',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),

        DefaultTabController(
          length: 3, // 탭의 수
          initialIndex: 0, // 초기 선택 탭의 인덱스
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'default'),
                  Tab(text: 'Tab 2'),
                  Tab(text: 'Tab 3'),
                ],
              ),
              Container(
                height: 300,
                child: TabBarView(
                  children: [
                    Container(
                      color: Colors.red,
                    ),
                    Container(
                      color: Colors.green,
                    ),
                    Container(
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _wishlistWidget(context),
    ]);
  }
}
