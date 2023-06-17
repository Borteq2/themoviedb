import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:themoviedb/di_examples/factories/di_container.dart';

abstract class AppFactory {
  Widget makeApp();
}

void main() {
  setupGetIt();
  final appFactory = GetIt.I<AppFactory>();
  final app = appFactory.makeApp();
  runApp(app);
}
