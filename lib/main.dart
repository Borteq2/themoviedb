import 'package:flutter/material.dart';
import 'package:themoviedb/di_examples/factories/di_container.dart';

abstract class MainDIContainer {
  Widget makeApp();
}
final diContainer = makeDIContainer();

void main() {
  final app = diContainer.makeApp();
  runApp(app);
}
