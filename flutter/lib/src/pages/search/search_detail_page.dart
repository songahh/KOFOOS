import 'package:flutter/material.dart';

import 'api/search_api.dart';


class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key,required this.itemNo});
  final String itemNo;


  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {

  SearchApi searchApi = SearchApi();
  late Future<dynamic> data;

  bool isLiked = false;
  int count =0;
  void initState() {
    super.initState();
    data = searchApi.getProductDetail(widget.itemNo).then((productData) {
      setState(() {
        count = productData['like'];
      });
      return productData;
    });
  }
  Like(){
    setState(() {
      isLiked = !isLiked;
      count += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, AsyncSnapshot<dynamic> snapshot)
      {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        else if (snapshot.hasData) {
          var data = snapshot.data;
          return Scaffold(
            body: DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.blue, // 컨테이너 배경색
                        borderRadius: BorderRadius.circular(
                            15),
                      ),
                      child: Image.network(
                        data['imgurl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container( // 카테고리
                      child: Text(data['categorySearchDto']['cat1']+
                          ">"+data['categorySearchDto']['cat2']
                          +">"+data['categorySearchDto']['cat3']
                          +">"+data['categorySearchDto']['cat4'])
                  ),
                  Container( // 먹태깡, 하트
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(data['name']),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$count",
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 1),
                              IconButton(
                                padding: EdgeInsets.symmetric(vertical: 3),
                                icon: Icon(
                                  isLiked ? Icons.favorite : Icons
                                      .favorite_outline,
                                ),
                                onPressed: () {
                                  print(count);
                                  Like();
                                },
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container( //상품설명
                    child: Text(data['description'] ?? 'No description available'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildChip(data['tagString'] ?? 'No tag available', Colors.white),
                      // _buildChip("설명", Color(0xFFff6666)),
                      // _buildChip("태그", Colors.white),
                    ],
                  ),
                  TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          'Ingredients',
                          style: TextStyle(fontSize: 13,
                              fontWeight: FontWeight.bold), // 원하는 폰트 크기로 지정
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Recommendation',
                          style: TextStyle(fontSize: 13,
                              fontWeight: FontWeight.bold), // 원하는 폰트 크기로 지정
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Available stock',
                          style: TextStyle(fontSize: 13,
                              fontWeight: FontWeight.bold), // 원하는 폰트 크기로 지정
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _Ingredient(data['dislikedMaterials'],"상세설명"),
                        Recommendation(),
                        stock(),
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
              foregroundColor: Color(0xff343F56), // 버튼의 배경색
            ),
          );
        }
        return  Text('Error');
      },
    );
  }

}

Widget _buildChip(String label, Color color) {
  return Chip(
      labelPadding: EdgeInsets.all(2.0),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10)
  );
}

Widget _Ingredient(List<dynamic>? dislikedMaterials, String Materialdetail) {
  List<Widget> chips = dislikedMaterials == null || dislikedMaterials.isEmpty
      ? [_buildChip("No allergy", Colors.white)]
      : dislikedMaterials
      .map<Widget>((material) => _buildChip(material.toString(), Colors.white))
      .toList();

  return Scrollbar(
    thickness: 10,
    child: ListView(
      children: [
        Column(
          children: [
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: chips,
            ),
            Container(
              child: Text(
                Materialdetail,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class Recommendation extends StatelessWidget {
  const Recommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView(
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                height: 150,
                child: Image.asset('assets/icon/chicken.png'),
              ),
              Container(
                width: 120,
                height: 150,
                child: Image.asset('assets/icon/chicken.png'),
              ),
              Container(
                width: 120,
                height: 150,
                child: Image.asset('assets/icon/chicken.png'),
              ),
              Container(
                width: 120,
                height: 150,
                child: Image.asset('assets/icon/chicken.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class stock extends StatelessWidget {
  const stock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: Image.asset('assets/warn/comingsoon.png'),
    );
  }
}



