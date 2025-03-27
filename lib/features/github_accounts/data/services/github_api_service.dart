import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'github_api_service.g.dart';

/// Retrofit service for interacting with GitHub's REST API.
@RestApi()
abstract class GitHubApiService {
  /// Creates a new instance of [GitHubApiService] with the given [Dio] client.
  factory GitHubApiService(Dio dio, {String baseUrl}) = _GitHubApiService;

  /// Searches GitHub users by query string.
  @GET('/search/users')
  Future<HttpResponse<Map<String, dynamic>>> searchUsers(
      @Query("q") String query);

  /// Retrieves user details by username.
  @GET('/users/{username}')
  Future<Map<String, dynamic>> getUserDetails(
      @Path("username") String username);

  /// Gets repositories for the specified GitHub user.
  @GET('/users/{username}/repos')
  Future<List<dynamic>> getUserRepos(@Path("username") String username);
}
