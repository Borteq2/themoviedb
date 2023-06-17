import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/library/secutiry_storage.dart';
import 'package:themoviedb/main.dart';
import 'package:themoviedb/ui/loader/loader_view_model.dart';
import 'package:themoviedb/ui/loader/loader_widget.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/ui/navigation/main_navigation_actions.dart';
import 'package:themoviedb/ui/widgets/app/my_app.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:themoviedb/ui/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:themoviedb/ui/widgets/news/news_widget.dart';
import 'package:themoviedb/ui/widgets/tv_show/tv_show_widget.dart';

AppFactory makeAppFactory() => const _AppFactoryDefault();

class _AppFactoryDefault implements AppFactory {
  const _AppFactoryDefault();

  final _diContainer = const _DIContainer();

  @override
  Widget makeApp() => MyApp(navigation: _diContainer.makeMyAppNavigation());
}

class _DIContainer {
  const _DIContainer();

  final _mainNavigationAction = const MainNavigationAction();
  final SecureStorage _secureStorage = const SecureStorageDefault();

  ScreenFactory makeScreenFactory() => ScreenFactoryDefault(this);

  MyAppNavigation makeMyAppNavigation() => MainNavigation(makeScreenFactory());

  SessionDataProvider makeSessionDataProvider() =>
      SessionDataProviderDefault(_secureStorage);

  AuthService makeAuthService() => AuthService();

  AuthViewModel makeAuthViewModel() => AuthViewModel(
        loginProvider: makeAuthService(),
        mainNavigationAction: _mainNavigationAction,
      );
}

class ScreenFactoryDefault implements ScreenFactory {
  ScreenFactoryDefault(this._diContainer);

  final _DIContainer _diContainer;

  @override
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  @override
  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => _diContainer.makeAuthViewModel(),
      child: const AuthWidget(),
    );
  }

  @override
  Widget makeMainScreen() {
    return const MainScreenWidget();
  }

  @override
  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsModel(movieId),
      child: const MovieDetailsWidget(),
    );
  }

  @override
  Widget makeMovieTrailer(String youTubeKey) {
    return MovieTrailerWidget(youTubeKey: youTubeKey);
  }

  @override
  Widget makeNewsList() {
    return const NewsWidget();
  }

  @override
  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListViewModel(),
      child: const MovieListWidget(),
    );
  }

  @override
  Widget makeTvShowList() {
    return const TvShowWidget();
  }
}
