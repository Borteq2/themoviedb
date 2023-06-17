import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:themoviedb/di_examples/main_navigation.dart';
import 'package:themoviedb/di_examples/ui/widgets/calculator_service.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_view_model.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_widget.dart';
import 'package:themoviedb/di_examples/ui/widgets/summator.dart';
import 'package:themoviedb/main.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';

void setupGetIt() {
  GetIt.instance
      .registerLazySingleton<ScreenFactory>(() => const ScreenFactoryDefault());
  GetIt.instance.registerSingleton<MainNavigation>(MainNavigationDefault());
  GetIt.I.registerFactory<Summator>(() => const Summator());
  GetIt.I.registerFactory<CalculatorService>(() => CalculatorService());
  GetIt.I.registerFactory<ExampleViewModel>(() => ExampleCalcViewModel());
  GetIt.I.registerFactory<AppFactory>(() => const AppFactoryDefault());
}

// class ServiceLocator {
//   static final instance = ServiceLocator._();
//
//   ServiceLocator._();
//
//   final MainNavigation mainNavigation = MainNavigationDefault();
//
//   Summator makeSummator() => const Summator();
//
//   CalculatorService makeCalculatorService() => CalculatorService();
//
//   ExampleViewModel makeExampleViewModel() => ExampleCalcViewModel();
//
//   Widget makeExampleScreen() => const ExampleWidget();
//
//   Widget makeApp() => MyApp();
// }

class ScreenFactoryDefault implements ScreenFactory {
  const ScreenFactoryDefault();

  @override
  Widget makeExampleScreen() => const ExampleWidget();
}

class AppFactoryDefault implements AppFactory {
  const AppFactoryDefault();

  @override
  Widget makeApp() => MyApp();
}
