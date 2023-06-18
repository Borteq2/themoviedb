import 'dart:io';

import 'package:themoviedb/configuration/configuration.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/api_client/network_client.dart';

abstract class AuthApiClient {
  Future<String> auth({
    required String username,
    required String password,
  });
}

class AuthApiClientDefault implements AuthApiClient {
  final NetworkClient networkClient;

  AuthApiClientDefault(this.networkClient);

  @override
  Future<String> auth({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validatedToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(
      requestToken: validatedToken,
    );
    return sessionId;
  }

  Future<String> _makeToken() async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = networkClient.get(
      '/authentication/token/new',
      parser,
      <String, dynamic>{'api_key': Configuration.apiKey},
    );
    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    try {
      String parser(dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        final sessionId = jsonMap['session_id'] as String;
        return sessionId;
      }

      final parameters = <String, dynamic>{'request_token': requestToken};
      final result = networkClient.post(
        '/authentication/session/new',
        parser,
        parameters,
        <String, dynamic>{'api_key': Configuration.apiKey},
      );
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    try {
      String parser(dynamic json) {
        final jsonMap = json as Map<String, dynamic>;
        final token = jsonMap['request_token'] as String;
        return token;
      }

      final parameters = <String, dynamic>{
        'username': username,
        'password': password,
        'request_token': requestToken
      };

      final result = networkClient.post(
        '/authentication/token/validate_with_login',
        parser,
        parameters,
        <String, dynamic>{'api_key': Configuration.apiKey},
      );
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (_) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }


}