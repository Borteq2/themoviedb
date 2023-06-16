import 'package:flutter/material.dart';
import 'package:themoviedb/di_examples/main_navigation.dart';
import 'package:themoviedb/di_examples/ui/widgets/calculator_service.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_view_model.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_widget.dart';
import 'package:themoviedb/di_examples/ui/widgets/summator.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';

class ServiceLocator {
  static final instance = ServiceLocator._();

  ServiceLocator._();

  final MainNavigation mainNavigation = MainNavigationDefault();

  Summator makeSummator() => const Summator();

  CalculatorService makeCalculatorService() => CalculatorService();

  ExampleViewModel makeExampleViewModel() => ExampleCalcViewModel();

  Widget makeExampleScreen() => ExampleWidget();

  Widget makeApp() => MyApp();
}
