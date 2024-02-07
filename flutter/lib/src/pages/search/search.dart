// import 'package:flutter/material.dart';
// import 'package:kofoos/src/pages/search/api/search_api.dart';
// import 'package:kofoos/src/pages/search/search_categoey_page.dart';
//
// class Search extends StatefulWidget {
//   Search({Key? key}) : super(key: key);
//
//   @override
//   _SearchState createState() => _SearchState();
// }
//
// class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;
//   SearchApi searchApi = SearchApi();
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );
//     _animation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//     _controller.forward();
//   }
//
//   Widget _rankingData(BuildContext context) {
//     return FutureBuilder<List<String>>(
//       future: searchApi.getRanking(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Text('');
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           List<String> ranking = snapshot.data!;
//           return ListView.builder(
//             itemCount: ranking.length,
//             itemBuilder: (context, index) {
//               if (index == 0) {
//                 // 랭킹 1위
//                 return Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 100.0,
//                   color: Color(0xff343F56),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 6.0,
//                       ),
//                       Image.asset(
//                         'assets/ranking/r1.png',
//                         width: 50.0,
//                         height: 50.0,
//                       ),
//                       SizedBox(width: 16.0),
//                       Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           ranking[index],
//                           style: TextStyle(
//                               fontSize: 24.0,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               } else if (index == 1 || index == 2) {
//                 // 랭킹 2, 3위
//                 return Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 100.0,
//                         color: index == 1 ? Colors.amber : Colors.redAccent,
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 6.0,
//                             ),
//                             Image.asset(
//                               'assets/ranking/r${index + 1}.png',
//                               width: 50.0,
//                               height: 50.0,
//                             ),
//                             SizedBox(width: 16.0),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 ranking[index],
//                                 style: TextStyle(
//                                   fontSize: 24.0,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               } else {
//                 // 랭킹 4~7위
//                 return Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: 60.0,
//                   color: Colors.grey,
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 26.0,
//                       ),
//                       Text(
//                         '${index + 1}',
//                         style: TextStyle(
//                             fontSize: 16.0,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       SizedBox(
//                         width: 40.0,
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           ranking[index],
//                           style: TextStyle(
//                               fontSize: 16.0,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//             },
//           );
//         }
//       },
//     );
//   }
//
//   Widget _rankingTitle(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 600,
//         ),
//         Text('data'),
//       ],
//     );
//   }
//
//   Widget _categoryAllButton(BuildContext context) {
//     return Positioned(
//       bottom: 30.0,
//       right: 30.0,
//       child: ElevatedButton(
//         onPressed: () {
//           print('카테고리 전체보기로 이동');
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SearchCategoryPage(),
//             ),
//           );
//         },
//         style: ElevatedButton.styleFrom(
//           primary: Color(0xff343F56),
//           onPrimary: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//         ),
//         child: Text('All  >', style: TextStyle(fontSize: 16)),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         _rankingData(context),
//         _categoryAllButton(context),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:kofoos/src/pages/search/api/search_api.dart';
import 'package:kofoos/src/pages/search/search_category_page.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  SearchApi searchApi = SearchApi();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  // Widget _buildRankingItem(
  //     BuildContext context, int index, List<String> ranking) {
  //   String rankingText = ranking[index];
  //
  //   if (index == 0 || index == 1 || index == 2) {
  //     // 랭킹 1, 2, 3위
  //     return Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: 100.0,
  //       color: index == 0
  //           // ? Color(0xff343F56)
  //           ? Colors.amber
  //           : (index == 1 ? Colors.grey : Colors.brown),
  //       child: Row(
  //         children: [
  //           SizedBox(
  //             width: 6.0,
  //           ),
  //           Image.asset(
  //             'assets/ranking/r${index + 1}.png',
  //             width: 50.0,
  //             height: 50.0,
  //           ),
  //           SizedBox(width: 16.0),
  //           Align(
  //             alignment: Alignment.center,
  //             child: Text(
  //               rankingText,
  //               style: TextStyle(
  //                 fontSize: 24.0,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     // 랭킹 4~7위
  //     return Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: 60.0,
  //       color: Color(0xffECECEC),
  //       child: Row(
  //         children: [
  //           SizedBox(
  //             width: 26.0,
  //           ),
  //           Text(
  //             '${index + 1}',
  //             style: TextStyle(
  //               fontSize: 16.0,
  //               color: Colors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(
  //             width: 40.0,
  //           ),
  //           Align(
  //             alignment: Alignment.centerLeft,
  //             child: Text(
  //               rankingText,
  //               style: TextStyle(
  //                 fontSize: 16.0,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }
  //
  Widget _rankingData(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: searchApi.getRanking(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('');
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<String> ranking = snapshot.data!;
          return ListView.builder(
            itemCount: ranking.length,
            itemBuilder: (context, index) {
              return _buildRankingItem(context, index, ranking);
            },
          );
        }
      },
    );
  }

  Widget _buildRankingItem(
      BuildContext context, int index, List<String> ranking) {
    String rankingText = ranking[index];

    if (index == 0 || index == 1 || index == 2) {
      // 랭킹 1, 2, 3위
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 100.0,
        decoration: BoxDecoration(
          color: index == 0
          // ? Color(0xff343F56)
              ? Colors.amber
              : (index == 1 ? Colors.grey : Colors.brown),
          borderRadius: BorderRadius.circular(12.0), // 모서리 둥글게
        ),
        child: Row(
          children: [
            SizedBox(
              width: 6.0,
            ),
            Image.asset(
              'assets/ranking/r${index + 1}.png',
              width: 50.0,
              height: 50.0,
            ),
            SizedBox(width: 16.0),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0), // 상하 패딩 추가
                child: Text(
                  rankingText,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // 랭킹 4~7위
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 60.0,
        decoration: BoxDecoration(
          color: Color(0xffECECEC),
          borderRadius: BorderRadius.circular(12.0), // 모서리 둥글게
        ),
        child: Row(
          children: [
            SizedBox(
              width: 26.0,
            ),
            Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 40.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0), // 상하 패딩 추가
                child: Text(
                  rankingText,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }


  Widget _rankingTitle(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 600,
        ),
        Text('data'),
      ],
    );
  }

  Widget _categoryAllButton(BuildContext context) {
    return Positioned(
      bottom: 30.0,
      right: 30.0,
      child: ElevatedButton(
        onPressed: () {
          print('카테고리 전체보기로 이동');
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchCategoryPage(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xff343F56),
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
        child: Text('All  >', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _rankingData(context),
        _categoryAllButton(context),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
