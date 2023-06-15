import 'package:flutter/material.dart';

abstract class MainNavigation {
  Map<String, Widget Function(BuildContext)> makeRoutes();
  Route<Object> onGenerateRoute(RouteSettings settings);
}

class MyApp extends StatelessWidget {
  // final ExampleCalcViewModel viewModel;
  final MainNavigation mainNavigation;
  const MyApp({Key? key, required this.mainNavigation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: ExampleWidget(model: viewModel),
      routes: mainNavigation.makeRoutes(),
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}


// class MyApp extends StatelessWidget {
//   static final mainNavigation = MainNavigation();
//
//   const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     theme: ThemeData(
  //       appBarTheme: const AppBarTheme(
  //         backgroundColor: AppColors.mainDarkBlue,
  //       ),
  //       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //         backgroundColor: AppColors.mainDarkBlue,
  //         selectedItemColor: Colors.white,
  //         unselectedItemColor: Colors.grey,
  //       ),
  //     ),
  //     localizationsDelegates: const [
  //       GlobalMaterialLocalizations.delegate,
  //       GlobalWidgetsLocalizations.delegate,
  //       GlobalCupertinoLocalizations.delegate,
  //     ],
  //     supportedLocales: const [
  //       Locale('ru', 'RU'),
  //       Locale('en', 'US'),
  //     ],
  //     routes: mainNavigation.routes,
  //     initialRoute: MainNavigationRouteNames.loaderWidget,
  //     onGenerateRoute: mainNavigation.onGenerateRoute,
  //   );
  // }
// }
