import 'package:flutter/material.dart';
import 'package:themoviedb/ui/navigation/main_navigation_route_names.dart';

class MainNavigationAction {
  const MainNavigationAction._();
  static const instance = MainNavigationAction._();


  void resetNavigation(BuildContext context) {
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.loaderWidget);
  }
}