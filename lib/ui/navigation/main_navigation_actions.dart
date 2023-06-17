import 'package:flutter/material.dart';
import 'package:themoviedb/ui/navigation/main_navigation_route_names.dart';

class MainNavigationAction {
  const MainNavigationAction();


  void resetNavigation(BuildContext context) {
    Navigator.of(context)
        .pushReplacementNamed(MainNavigationRouteNames.loaderWidget);
  }
}