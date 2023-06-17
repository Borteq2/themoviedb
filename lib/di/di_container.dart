import 'package:flutter/material.dart';
import 'package:themoviedb/main.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';

AppFactory makeAppFactory() => const _AppFactoryDefault();

class _AppFactoryDefault implements AppFactory {
  const _AppFactoryDefault();

  final _diContainer = const _DIContainer();

  @override
  Widget makeApp() => const MyApp();
}

class _DIContainer {
  const _DIContainer();


}
