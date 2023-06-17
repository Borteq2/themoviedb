import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';

abstract class MainNavigationRouteNames {
  static const example = '/';
}

abstract class ScreenFactory {
  Widget makeExampleScreen();
}

class MainNavigationDefault implements MainNavigation {
  final screenFactory = GetIt.I<ScreenFactory>();

  MainNavigationDefault();

  @override
  Map<String, Widget Function(BuildContext)> makeRoutes() =>
      <String, Widget Function(BuildContext)>{
        MainNavigationRouteNames.example: (_) =>
            screenFactory.makeExampleScreen(),
      };

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case MainNavigationRouteNames.movieDetails:
      //   final arguments = settings.arguments;
      //   final movieId = arguments is int ? arguments : 0;
      //   return MaterialPageRoute(
      //       builder: (_) => _screenFactory.makeMovieDetails(movieId));
      // case MainNavigationRouteNames.movieTrailerWidget:
      //   final arguments = settings.arguments;
      //   final youTubeKey = arguments is String ? arguments : '';
      //   return MaterialPageRoute(
      //       builder: (_) => _screenFactory.makeMovieTrailer(youTubeKey));
      default:
        const widget = Text('Navigation error!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}
