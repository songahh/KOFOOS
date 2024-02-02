import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kofoos/src/common/appbar_widget.dart';
import 'package:kofoos/src/pages/mypage/mypage.dart';
import 'package:kofoos/src/pages/search/search.dart';
import 'package:kofoos/src/pages/home/home.dart';
import 'package:kofoos/src/pages/camera/camera.dart';
import 'package:kofoos/src/pages/wishlist/wishlist.dart';
import 'package:kofoos/src/root/root_controller.dart';

class Root extends GetView<RootController> {
  Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Obx(
        () => Scaffold(
          appBar: MyAppBar(),
          body: IndexedStack(
            index: controller.rootPageIndex.value,
            children: [
              Navigator(
                // key: controller.navigatorKey,
                key: UniqueKey(),
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => const Home(),
                  );
                },
              ),
              Navigator(
                key: UniqueKey(),
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => Search(),
                  );
                },
              ),
              const Camera(),
              const Wishlist(),
              const Mypage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.rootPageIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: controller.changeRootPageIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Color(0xffCACACA)),
                label: 'home',
                activeIcon: Icon(Icons.home, color: Colors.black),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search, color: Color(0xffCACACA)),
                label: 'search',
                activeIcon: Icon(Icons.search, color: Colors.black),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt, color: Color(0xffCACACA)),
                label: 'camera',
                activeIcon: Icon(Icons.camera_alt, color: Colors.black),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, color: Color(0xffCACACA)),
                label: 'wishlist',
                activeIcon: Icon(Icons.favorite, color: Colors.black),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Color(0xffCACACA)),
                label: 'mypage',
                activeIcon: Icon(Icons.person, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
