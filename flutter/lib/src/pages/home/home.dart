import 'package:flutter/material.dart';
import 'package:kofoos/src/pages/home/home_editor_page_2.dart';
import 'package:kofoos/src/pages/home/home_editor_page_3.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kofoos/src/pages/home/home_editor_page_1.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  Widget _homeEditorWidget(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      itemBuilder: (BuildContext context, int index, int realIndex) {
        return GestureDetector(
          onTap: () {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeEditorPage1(),
                ),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeEditorPage2(),
                ),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeEditorPage3(),
                ),
              );
            }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
                image: AssetImage('assets/editor/e$index.jpg'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _homeRecommendWidget1(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Text(
              'What\'s Hot in Korea🔥',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                print('해당 테마 상품 전체보기 기능 추가 필요');
              },
              child: Text(
                'All  >',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0;
                i < 10;
                i++)
                  GestureDetector(
                    onTap: () {
                      print('$i번 상품 상세보기 기능 추가 필요');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Divider(
          height: 40,
          thickness: 2.0,
          color: Color(0xffECECEC),
        ),
      ],
    );
  }

  Widget _homeRecommendWidget2(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Text(
              'What\'s Hot in Korea🔥',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                print('해당 테마 상품 전체보기 기능 추가 필요');
              },
              child: Text(
                'All  >',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (int i = 0;
                    i < 10;
                    i++)
                  GestureDetector(
                    onTap: () {
                      print('$i번 상품 상세보기 기능 추가 필요');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _homeEditorWidget(context),
          _homeRecommendWidget1(context),
          _homeRecommendWidget2(context),
        ],
      ),
    );
  }
}
