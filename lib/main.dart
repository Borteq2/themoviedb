import 'package:flutter/material.dart';
import 'package:themoviedb/di/di_container.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';

abstract class AppFactory {
  Widget makeApp();
}

final appFactory = makeAppFactory();

void main() {
  final app = appFactory.makeApp();
  runApp(app);
}
