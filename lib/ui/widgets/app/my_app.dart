import 'package:flutter/material.dart';
import 'package:themoviedb/di_examples/ui/widgets/example_widget.dart';
import 'package:themoviedb/ui/Theme/app_colors.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExampleWidget(),
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
