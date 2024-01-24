import 'package:flutter/material.dart';

class Scanning with ChangeNotifier{
  bool _scanning = false;
  bool get scanning => _scanning;

  void start() {
    _scanning = true;
    notifyListeners();
  }

  void end() {
    _scanning = false;
    notifyListeners();
  }
}