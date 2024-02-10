import 'package:flutter/material.dart';
import 'package:kofoos/src/pages/mypage/dto/ProductDto.dart';
import 'package:kofoos/src/pages/mypage/func/users_delete_func.dart';
import 'package:kofoos/src/pages/mypage/func/users_update_lang_func.dart';
import 'package:kofoos/src/pages/mypage/api/mypage_api.dart';
import 'package:kofoos/src/pages/mypage/dto/my_page_dto.dart';
import 'package:kofoos/src/pages/mypage/update_materials_page.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../register/select_food.dart';
import 'mypage_notifier.dart';


class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> {

  Widget _historyCarouselWidget(List<ProductDto> products) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // 가로 스크롤 설정
      child: Row(
        children: products.map((productDto) => GestureDetector(
          onTap: () {
            print('${productDto.productItemNo} 상품 상세보기 기능 추가 필요');
          },
          child: Container(
            width: 125, // 이미지 컨테이너 너비 설정
            height: 125, // 이미지 컨테이너 높이 설정
            margin: EdgeInsets.all(5), // 주변 여백 설정
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), // 모서리 둥글게 처리
              image: DecorationImage(
                fit: BoxFit.cover, // 이미지를 컨테이너에 꽉 채우도록 설정
                image: CachedNetworkImageProvider(productDto.productUrl), // 캐시된 네트워크 이미지 로드
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }

  Widget _myPageWidget(BuildContext context, MyPageDto info) {
    // Disliked Foods 섹션을 위한 위젯 구성
    Widget dislikedFoodsSection = _dislikedFoodsSection(info.dislikedMaterials);

    // History 섹션을 위한 위젯 구성
    Widget historySection = Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('History',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
          ),
          // 히스토리 사진을 캐러셀로 표시하는 위젯을 여기에 배치
          _historyCarouselWidget(info.products),
        ],
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 70,

            color: const Color(0xff343F56),

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 32,
                  ),
                  const Text(
                    ' My page',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // 유저 회원탈퇴 api

                      usersDeleteFunc(context,29);

                    },
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.grey,
                        decorationThickness: 2.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 20.0,
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: [

                Expanded(
                  child: ListTile(
                    title: const Text('Language',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // 언어 변경 함수
                        usersUpdateLangFunc(context);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffECECEC),
                      ),
                      child: Text(
                        info.language, // 유저가 선택한 언어 출력
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20.0,
            color: Colors.white,
          ),
          const Divider(
            color: Color(0xffECECEC),
            height: 2.0,
            thickness: 2.0,
          ),
          Container(
            height: 10.0,
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
            child: ListTile(
              title: const Text('Disliked Foods',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
              trailing: TextButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DislikeFoodEditPage(userId: 14)),
                  );
                  if (result == true) {
                    Provider.of<MyPageNotifier>(context, listen: false).fetchMyPageInfo(14);
                  }
                },
                child: const Text(
                  'More details',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey,
                    decorationThickness: 2.0,
                  ),
                ),
              ),
              subtitle: dislikedFoodsSection, //dislikedFood 섹션
            ),
          ),
          Container(
            height: 10.0,
            color: Colors.white,
          ),
          const Divider(
            color: Color(0xffECECEC),
            height: 2.0,
            thickness: 2.0,
          ),
          historySection, // History 섹션
          const SizedBox(height: 40.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text(
              'KOFOOS\nSeoul, Korea\nContact kofoos@gmail.com',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xffCACACA),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dislikedFoodsSection(List<int> dislikedFoodIds) {
    List<Widget> dislikedFoodWidgets = foodList
        .where((food) => dislikedFoodIds.contains(food.id))
        .take(3) // 최대 3개의 아이템만 표시
        .map((food) => buildDislikedFoodWidget(food))
        .toList();

    return Wrap(
      spacing: 8.0,
      children: dislikedFoodWidgets,
    );
  }

  Widget buildDislikedFoodWidget(Food food) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/icon/${food.image}.png', width: 75, height: 75), // 이미지 크기는 적절하게 조절
        Text(food.name), // 음식 이름
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    // Provider를 사용하여 상태를 관리합니다.
    return ChangeNotifierProvider<MyPageNotifier>(
      create: (_) => MyPageNotifier(),
      child: Consumer<MyPageNotifier>(
        builder: (context, notifier, _) {
          return Scaffold(
            body: notifier.myPageInfo == null
                ? const Center(child: CircularProgressIndicator())
                : _myPageWidget(context, notifier.myPageInfo!),
          );
        },
      ),
    );
  }


}

