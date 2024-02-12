import 'package:flutter/material.dart';
import 'package:kofoos/src/common/back_button_widget.dart';
import 'package:kofoos/src/pages/search/search_detail_page.dart';

import 'api/search_api.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage(
      {Key? key, required this.cat1, required this.cat2, required this.order})
      : super(key: key);

  final String cat1;
  final String cat2;
  final String order;

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  SearchApi searchApi = SearchApi();
  late Future<dynamic> data;
  int visibleItemCount = 15;

  @override
  void initState() {
    super.initState();
    data = searchApi.getProducts(widget.cat1, widget.cat2, widget.order);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          var products = snapshot.data as List<dynamic>;
          var length = products.length;
          return Material(
            child: Stack(
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      setState(() {
                        visibleItemCount =
                            (visibleItemCount + 15).clamp(0, products.length);
                      });
                    }
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          'Product($length)',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),
                        SizedBox(height: 30),
                        Center(
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: products
                                .sublist(
                                0, visibleItemCount.clamp(0, products.length))
                                .map((product) => _product(context, product))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BackButtonWidget(),
              ],
            ),
          );
        }
        return Text('Error');
      },
    );
  }
}

Widget _product(BuildContext context, dynamic item) {
  String httpImgUrl = item['imgurl'].replaceFirst('https', 'http');
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailView(
            itemNo: item['itemNo'],
          ),
        ),
      );
    },
    child: Container(
      width: 120,
      height: 150,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(httpImgUrl, fit: BoxFit.cover),
      ),
    ),
  );
}