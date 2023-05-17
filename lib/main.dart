import 'package:flutter/material.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';

import 'widgets/auth/auth_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(3, 37, 65, 1),
        ),
      ),
      routes: {
        '/auth': (context) => const AuthWidget(),
        // '/main_screen': (context) => MainScreenWidget(),
        '/main_screen': (context) => const MainScreenWidget(),
      },
      initialRoute: '/auth',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('Ошибка навигации'),
            ),
          );
        });
      },
    );
  }
}
