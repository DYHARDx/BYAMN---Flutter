import 'dart:async';

import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 0;
  bool _isChangingTab = false;

  int get currentIndex => _currentIndex;
  bool get isChangingTab => _isChangingTab;

  Future<void> changeTab(int index) async {
    if (_currentIndex == index) return;
    _isChangingTab = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 900));
    _currentIndex = index;
    _isChangingTab = false;
    notifyListeners();
  }
}
