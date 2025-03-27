// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GitHubApiService implements GitHubApiService {
  _GitHubApiService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.github.com';
  }

  final Dio _dio;
  String? baseUrl;

  @override
  Future<HttpResponse<Map<String, dynamic>>> searchUsers(String query) async {
    final queryParams = <String, dynamic>{'q': query};
    final result = await _dio.get<Map<String, dynamic>>(
      '/search/users',
      queryParameters: queryParams,
      options: Options(responseType: ResponseType.json),
    );
    return HttpResponse(result.data!, result);
  }

  @override
  Future<Map<String, dynamic>> getUserDetails(String username) async {
    final result = await _dio.get<Map<String, dynamic>>(
      '/users/$username',
      options: Options(responseType: ResponseType.json),
    );
    return result.data!;
  }

  @override
  Future<List<dynamic>> getUserRepos(String username) async {
    final result = await _dio.get<List<dynamic>>(
      '/users/$username/repos',
      options: Options(responseType: ResponseType.json),
    );
    return result.data!;
  }
}
