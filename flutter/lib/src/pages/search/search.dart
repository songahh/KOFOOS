import 'dart:math';

import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  Search({super.key});

  Widget _rankingWidget(BuildContext context) {
    List<Widget> rankingCircles = [];
    List<int> rankingOrders = [1, 2, 3, 4, 5, 6, 7];
    rankingOrders.shuffle();

    for (int i = 0; i < rankingOrders.length; i++) {
      int ranking = rankingOrders[i];
      double size = 100.0 - (ranking * 5.0);
      if (ranking == 1) {
        size += 80.0;
      } else if (ranking == 2) {
        size += 40.0;
      } else if (ranking == 3) {
        size += 20.0;
      } else if (ranking == 4) {
        size += 5.0;
      } else if (ranking == 5) {
        size += 5.0;
      } else if (ranking == 6) {
        size += 5.0;
      } else if (ranking == 7) {
        size -= 5.0;
      }

      Widget circleWidget = GestureDetector(
        onTap: () {
          print('$ranking번 랭킹 클릭: 해당하는 소분류 카테고리 검색 이동 구현 필요');
        },
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              '$ranking',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

      double x = 12.0 + Random().nextDouble() *
          (MediaQuery.of(context).size.width - 2 * 12.0 - size);

      double y = Random().nextDouble() *
          (MediaQuery.of(context).size.height - 300 - size);

      rankingCircles.add(Positioned(
        left: x,
        top: y,
        child: circleWidget,
      ));
    }

    return Stack(
      children: rankingCircles,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _rankingWidget(context);
  }
}
