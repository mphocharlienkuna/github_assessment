import 'package:dio/dio.dart';
import '../../config/env.dart';
import '../constants/app_constants.dart';

/// Provides a configured Dio HTTP client for API requests.
class DioProvider {
  /// Creates a Dio instance with GitHub base URL and auth headers.
  static Dio createDio() {
    final token = Env.githubToken;
    return Dio(
      BaseOptions(
        baseUrl: AppConstants.githubBaseUrl,
        headers: {
          'Authorization': 'token $token',
          'Accept': 'application/vnd.github.v3+json',
        },
      ),
    );
  }
}
