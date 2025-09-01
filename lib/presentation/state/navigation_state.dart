import 'dart:async';

import 'package:flutter/widgets.dart';

class NavigationState {
  final StreamController<int> _pageController =
      StreamController<int>.broadcast();
  int _currentPageIndex = 2;

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

class NavigationStateProvider extends InheritedWidget {
  final NavigationState navigationState = NavigationState();

  NavigationStateProvider({super.key, required super.child});

  static NavigationState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<NavigationStateProvider>()!
        .navigationState;
  }

  @override
  bool updateShouldNotify(NavigationStateProvider oldWidget) => false;
}
