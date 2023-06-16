import 'package:flutter/material.dart';
import 'package:themoviedb/di_examples/factories/di_container.dart';

void main() {
  final app = ServiceLocator.instance.makeApp();
  runApp(app);
}
