import 'package:flutter/material.dart';
import 'package:kofoos/src/pages/search/api/search_api.dart';
import 'package:kofoos/src/pages/search/search_categoey_page.dart';

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

  Widget _floatingActionButton(BuildContext context) {
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

  Widget _rankingData(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: searchApi.getRanking(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<String> ranking = snapshot.data!;
          return ListView.builder(
            itemCount: ranking.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(ranking[index]),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _rankingData(context),
        _floatingActionButton(context),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
