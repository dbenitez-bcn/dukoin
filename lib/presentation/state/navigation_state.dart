
import 'dart:async';

import 'package:flutter/widgets.dart';

class NavigationState extends InheritedWidget {
  final StreamController<int> _pageController = StreamController<int>.broadcast();
  int _currentPageIndex = 0;

  NavigationState({super.key, required super.child});


  @override
  bool updateShouldNotify(covariant NavigationState oldWidget) {
    return oldWidget._currentPageIndex != _currentPageIndex;
  }

  static NavigationState of(BuildContext context) {
    final NavigationState? result =
      context.dependOnInheritedWidgetOfExactType<NavigationState>();
    assert(result != null, 'No NavigationState found in context');
    return result!;
  }

  Stream<int> get currentPageStream => _pageController.stream;
  int get currentPageIndex => _currentPageIndex;

  void setPageIndex(int newIndex) {
    if (newIndex != _currentPageIndex) {
      _currentPageIndex = newIndex;
      _pageController.add(newIndex);
    }
  }

  void dispose() {
    _pageController.close();
  }
}