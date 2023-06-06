import 'dart:io';

import 'package:themoviedb/configuration/configuration.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/api_client/network_client.dart';

enum MediaType { movie, tv }

extension MediaTypeAsString on MediaType {
  String asString() {
    switch (this) {
      case MediaType.movie:
        return 'movie';
      case MediaType.tv:
        return 'tv';
    }
  }
}

class AccountApiClient {
  final _networkClient = NetworkClient();

  Future<int> getAccountInfo(String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }

    final result = _networkClient.get(
      '/account',
      parser,
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  Future<int> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    try {
      int parser(dynamic json) {
        return 1;
      }

      final parameters = <String, dynamic>{
        'media_type': mediaType.asString(),
        'media_id': mediaId,
        'favorite': isFavorite,
      };

      final result = _networkClient.post(
        '/account/$accountId/favorite',
        parser,
        parameters,
        <String, dynamic>{
          'api_key': Configuration.apiKey,
          'session_id': sessionId,
        },
      );
      return result;
    } on SocketException {
      throw ApiClientException(ApiClientExceptionType.network);
    } on ApiClientException {
      rethrow;
    } catch (e) {
      throw ApiClientException(ApiClientExceptionType.other);
    }
  }
}
