import 'package:flutter/material.dart';
import 'package:themoviedb/di_examples/ui/widgets/calculator_service.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_view_model.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_widget.dart';
import 'package:themoviedb/di_examples/ui/widgets/summator.dart';
import 'package:themoviedb/main.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';

MainDIContainer makeDIContainer() => _DIContainer();

class _DIContainer implements MainDIContainer{
  // late final Summator _summator;
  Summator _makeSummator() => const Summator();

  CalculatorService _makeCalculatorService() => CalculatorService(
        _makeSummator(),
      );

  ExampleViewModel _makeExampleViewModel() => ExampleCalcViewModel(
        _makeCalculatorService(),
      );

  Widget makeExampleWidget() => ExampleWidget(
        model: _makeExampleViewModel(),
      );

  Widget makeApp() => MyApp(
        widget: makeExampleWidget(),
      );

  _DIContainer();
}
