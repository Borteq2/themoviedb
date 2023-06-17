import 'package:flutter/material.dart';
import 'package:themoviedb/domain/factories/screen_factory.dart';
import 'package:themoviedb/ui/navigation/main_navigation_route_names.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';

abstract class ScreenFactory {
  Widget makeLoader();
  Widget makeAuth();
  Widget makeMainScreen();
  Widget makeMovieDetails(int movieId);
  Widget makeMovieTrailer(String youTubeKey);
  Widget makeNewsList();
  Widget makeMovieList();
  Widget makeTvShowList();
}

class MainNavigation implements MyAppNavigation {
  final ScreenFactory screenFactory;

  const MainNavigation(this.screenFactory);

  @override
  Map<String, Widget Function(BuildContext)> get routes =>
      <String, Widget Function(BuildContext)>{
        MainNavigationRouteNames.loaderWidget: (_) =>
            screenFactory.makeLoader(),
        MainNavigationRouteNames.auth: (_) => screenFactory.makeAuth(),
        MainNavigationRouteNames.mainScreen: (_) =>
            screenFactory.makeMainScreen(),
      };

  @override
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
            builder: (_) => screenFactory.makeMovieDetails(movieId));
      case MainNavigationRouteNames.movieTrailerWidget:
        final arguments = settings.arguments;
        final youTubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
            builder: (_) => screenFactory.makeMovieTrailer(youTubeKey));
      default:
        const widget = Text('Navigation error!');
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}
