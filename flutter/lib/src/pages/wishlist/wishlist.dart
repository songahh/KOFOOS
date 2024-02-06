import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({Key? key}) : super(key: key);

  Widget _wishlistWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 70,
          color: Color(0xff343F56),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
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
          length: 3,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'default'),
                  Tab(text: 'folder'),
                  Tab(text: 'folder'),
                ],
              ),
              Container(
                height: 900,
                child: TabBarView(
                  children: [
                    Container(
                      color: Colors.blue,
                    ),
                    Container(
                      color: Colors.green,
                    ),
                    Container(
                      color: Colors.amber,
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

  Widget _wishlistFolderButton(BuildContext context) {
    return Positioned(
      bottom: 100.0,
      right: 30.0,
      child: FloatingActionButton(
        onPressed: () {
          print('위시리스트 폴더 수정 기능 추가 필요');
        },
        child: Icon(Icons.folder),
        backgroundColor: Color(0xffECECEC),
        foregroundColor: Color(0xff343F56),
      ),
    );
  }

  Widget _wishlistUploadButton(BuildContext context) {
    return Positioned(
      bottom: 30.0,
      right: 30.0,
      child: FloatingActionButton(
        onPressed: () {
          print('위시리스트 업로드 기능 추가 필요');
        },
        child: Icon(Icons.cloud_upload),
        backgroundColor: Color(0xffECECEC),
        foregroundColor: Color(0xff343F56),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(children: [
            _wishlistWidget(context),
          ]),
        ),
        _wishlistFolderButton(context),
        _wishlistUploadButton(context),
      ],
    );
  }
}
