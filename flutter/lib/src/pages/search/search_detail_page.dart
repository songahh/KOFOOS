import 'dart:math';

import 'package:flutter/material.dart';

import 'api/search_api.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key, required this.itemNo});

  final String itemNo;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView>
    with SingleTickerProviderStateMixin {
  SearchApi searchApi = SearchApi();
  late Future<dynamic> data;
  bool isLiked = false;
  int count = 0;
  late String productId = '';
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    data = searchApi.getProductDetail(widget.itemNo).then(
      (productData) {
        setState(() {
          count = productData['like'];
          productId = productData['productId'].toString();
        });
        return productData;
      },
    );
  }

  Like() {
    setState(() {
      isLiked = !isLiked;
      count += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var data = snapshot.data;
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.network(
                        data['imgurl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    // 카테고리
                    child: Text(
                      '   ${data['categorySearchDto']['cat1']}' +
                          " >  " +
                          data['categorySearchDto']['cat2'] +
                          " >  " +
                          data['categorySearchDto']['cat3'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    // 상품명
                    '  ${data['name']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    // 좋아요
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        margin: EdgeInsets.only(right: 16),
                        width: 85,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "   $count",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 1),
                            IconButton(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              icon: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: isLiked ? Colors.red : Colors.white,
                              ),
                              onPressed: () {
                                print(count);
                                Like();
                              },
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffCACACA),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Container(
                    // 상품설명
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child:
                        Text(data['description'] ?? 'No description available'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildTags(data['tagString'] ?? 'No tag available',
                          Colors.white),
                    ],
                  ),
                  Container(
                    height: 100,
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                          child: Text(
                            'Ingredients',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Recommendation',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Available stock',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          // 좌우 여유 공간 설정
                          child: _Ingredient(data['dislikedMaterials'], ""),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          // 좌우 여유 공간 설정
                          child: Recommendation(productId: productId),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          // 좌우 여유 공간 설정
                          child: Stock(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back),
              backgroundColor: Color(0xffECECEC),
              foregroundColor: Color(0xff343F56),
            ),
          );
        }
        return Text('Error');
      },
    );
  }
}

Widget _buildTags(String label, Color color) {
  return Chip(
    labelPadding: EdgeInsets.all(2.0),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Color(0xff343F56),
    elevation: 0.0,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
}

Widget _buildChip(String label, Color color) {
  IconData? icon;
  if (label != 'No disliked materials') {
    icon = Icons.error;
  }

  return Chip(
    labelPadding: EdgeInsets.all(2.0),
    label: Row(
      mainAxisSize: MainAxisSize.min, // 수정: Row의 크기를 최소화
      children: [
        if (icon != null)
          Icon(
            icon,
            color: Colors.red,
            size: 18,
          ),
        SizedBox(width: icon != null ? 5 : 0),
        Flexible(
          // 수정: 칩이 사용 가능한 영역만큼만 차지
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.amber,
    elevation: 0.0,
    shadowColor: Colors.transparent,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );
}

Widget _Ingredient(List<dynamic>? dislikedMaterials, String materialDetail) {
  List<Widget> chips = dislikedMaterials == null || dislikedMaterials.isEmpty
      ? [_buildChip("No disliked materials", Colors.white)]
      : dislikedMaterials
          .map<Widget>(
              (material) => _buildChip(material.toString(), Colors.white))
          .toList();

  return Scrollbar(
    thickness: 10,
    child: Wrap(
      alignment: WrapAlignment.start,
      spacing: 5.0,
      runSpacing: 5.0, // 가로로 나열하면서 줄바꿈
      children: [
        ...chips,
        Container(
          child: Text(
            materialDetail,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    ),
  );
}

class Recommendation extends StatelessWidget {
  String productId;

  Recommendation({Key? key, required this.productId}) : super(key: key);
  SearchApi searchApi = SearchApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: searchApi.getRecommendProducts(productId),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('오류: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data != null) {
          List<dynamic> recommendedProducts = snapshot.data!;

          // 최대 6개의 아이템만 선택
          recommendedProducts = recommendedProducts.take(6).toList();

          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 8.0, // 가로 간격 조절
            runSpacing: 4.0, // 세로 간격 조절
            children: recommendedProducts.map((product) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailView(
                        itemNo: product['itemNo'],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.all(4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          product['imgUrl'],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        }
        return Text('추천 제품이 없습니다.');
      },
    );
  }
}

class Stock extends StatelessWidget {
  const Stock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Image.asset('assets/warn/comingsoon.png'),
    );
  }
}
