import 'package:flutter/material.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';
import 'package:themoviedb/ui/navigation/main_navigation_route_names.dart';



class MainNavigation {
  final _screenFactory = ScreenFactory();

  Map<String, Widget Function(BuildContext)> get routes =>
      <String, Widget Function(BuildContext)>{
        MainNavigationRouteNames.loaderWidget: (_) =>
            _screenFactory.makeLoader(),
        MainNavigationRouteNames.auth: (_) => _screenFactory.makeAuth(),
        MainNavigationRouteNames.mainScreen: (_) =>
            _screenFactory.makeMainScreen(),
      };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeMovieDetails(movieId));
      case MainNavigationRouteNames.movieTrailerWidget:
        final arguments = settings.arguments;
        final youTubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
            builder: (_) => _screenFactory.makeMovieTrailer(youTubeKey));
      default:
        const widget = Text('Navigation error!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }

}
