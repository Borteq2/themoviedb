import 'dart:async';
import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/ui/navigation/main_navigation_actions.dart';

abstract class AuthViewModelLoginProvider {
  Future<void> login(String login, String password);
}

class AuthViewModel extends ChangeNotifier {
  final MainNavigationAction mainNavigationAction;
  final AuthViewModelLoginProvider loginProvider;

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  bool _isAuthProgress = false;
  String? get errorMessage => _errorMessage;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  AuthViewModel({
    required this.mainNavigationAction,
    required this.loginProvider,
  });

  bool _isValid(String login, String password) =>
      login.isNotEmpty || password.isNotEmpty;

  Future<String?> _login(String login, String password) async {
    try {
      await loginProvider.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'Сервер недоступен, проверьте подключение к Интернет';
        case ApiClientExceptionType.auth:
          return 'Неверный логин или пароль';
        case ApiClientExceptionType.other:
          return 'Неожиданная ошибка, попробуйте ещё раз';
        case ApiClientExceptionType.sessionExpired:
          print(e);
      }
    } catch (e) {
      return 'Что-то сломалось';
    }
    return null;
  }

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      _updateState('Заполните логин и пароль', false);
      return;
    }
    _updateState(null, true);

    _errorMessage = await _login(login, password);
    if (_errorMessage == null) {
      mainNavigationAction.resetNavigation(context);
    } else {
      _updateState(_errorMessage, false);
    }
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}
