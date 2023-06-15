import 'package:flutter/material.dart';
import 'package:themoviedb/di_examples/main_navigation.dart';
import 'package:themoviedb/di_examples/ui/widgets/calculator_service.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_view_model.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_widget.dart';
import 'package:themoviedb/di_examples/ui/widgets/summator.dart';
import 'package:themoviedb/main.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';

MainDIContainer makeDIContainer() => _DIContainer();

class _DIContainer implements MainDIContainer, ScreenFactory {
  // late final Summator _summator;
  late final MainNavigation _mainNavigation;

  Summator _makeSummator() => const Summator();

  CalculatorService _makeCalculatorService() =>
      CalculatorService(
        _makeSummator(),
      );

  ExampleViewModel _makeExampleViewModel() =>
      ExampleCalcViewModel(
        _makeCalculatorService(),
      );

  @override
  Widget makeExampleScreen() =>
      ExampleWidget(
        model: _makeExampleViewModel(),
      );


  @override
  Widget makeApp() => MyApp(mainNavigation: _mainNavigation);

  _DIContainer() {
    _mainNavigation = MainNavigationDefault(this);
  }
}
