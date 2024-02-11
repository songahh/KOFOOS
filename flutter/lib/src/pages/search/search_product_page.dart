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
                        Text('Product'),
                        SizedBox(height: 30),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: products
                              .sublist(
                              0, visibleItemCount.clamp(0, products.length))
                              .map((product) => _product(context, product))
                              .toList(),
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
      child: Image.network(httpImgUrl),
    ),
  );
}