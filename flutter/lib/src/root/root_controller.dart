import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RootController extends GetxController {
  static RootController get to => Get.find();
  RxInt rootPageIndex = 0.obs;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RxBool isMultiplePageOpen = false.obs;
  DateTime? currentBackPressTime;


  var isEditing = false.obs;

  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  void changeRootPageIndex(int index) {
    rootPageIndex(index);
    print("Current Root Page Index: ${rootPageIndex.value}");
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Double tap the back button\nto close the APP",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xff6E6E6E),
          fontSize: 20,
          toastLength: Toast.LENGTH_SHORT);
      return false;
    }
    return true;
  }

  void setMultiplePage(bool ck) {
    isMultiplePageOpen(ck);
  }

  void back() {
    setMultiplePage(false);
    onWillPop();
  }
}
