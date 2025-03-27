import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/github_account_entity.dart';
import '../../domain/entities/github_user_details_entity.dart';
import '../../domain/entities/github_repository_entity.dart';
import '../../domain/repositories/github_account_repository.dart';
import '../models/github_account_dto.dart';
import '../models/github_user_details_dto.dart';
import '../models/github_repository_dto.dart';
import '../services/github_api_service.dart';

/// Implementation of [GitHubAccountRepository] that uses the GitHub API.
class GitHubAccountRepositoryImpl implements GitHubAccountRepository {
  final GitHubApiService apiService;

  GitHubAccountRepositoryImpl(this.apiService);

  /// A helper function to handle errors for API calls
  Future<T> _handleError<T>(
      Future<T> Function() request, String logPrefix) async {
    try {
      return await request();
    } on UnauthorizedAccessException catch (e) {
      appLog('$logPrefix Unauthorized access: $e');
      rethrow;
    } on NotFoundException catch (e) {
      appLog('$logPrefix Not found: $e');
      rethrow;
    } on BadRequestException catch (e) {
      appLog('$logPrefix Bad request: $e');
      rethrow;
    } on ServerErrorException catch (e) {
      appLog('$logPrefix Server error: $e');
      rethrow;
    } on NetworkException catch (e) {
      appLog('$logPrefix Network exception: $e');
      rethrow;
    } on TimeoutException catch (e) {
      appLog('$logPrefix Timeout exception: $e');
      rethrow;
    } catch (e) {
      appLog('$logPrefix Unknown error: $e');
      throw UnknownErrorException('An unknown error occurred.');
    }
  }

  /// Searches for GitHub users matching the query.
  @override
  Future<List<GitHubAccountEntity>> searchAccounts(String query) async {
    return _handleError<List<GitHubAccountEntity>>(
      () async {
        final response = await apiService.searchUsers(query);

        if (response.data['items'] == null) {
          throw NetworkException(message: "No data found for the query.");
        }

        final items = response.data['items'] as List;
        return items
            .map((e) => GitHubAccountDTO.fromJson(e).toEntity())
            .toList();
      },
      "Search Accounts",
    );
  }

  /// Fetches detailed information for a specific GitHub user.
  @override
  Future<GitHubUserDetailsEntity> getUserDetails(String username) async {
    return _handleError<GitHubUserDetailsEntity>(
      () async {
        final json = await apiService.getUserDetails(username);
        return GitHubUserDetailsDTO.fromJson(json).toEntity();
      },
      "Fetch User Details",
    );
  }

  /// Retrieves repositories for a specific GitHub user.
  @override
  Future<List<GitHubRepositoryEntity>> getUserRepositories(
      String username) async {
    return _handleError<List<GitHubRepositoryEntity>>(
      () async {
        final repos = await apiService.getUserRepos(username);
        return repos
            .map((e) => GitHubRepositoryDTO.fromJson(e).toEntity())
            .toList();
      },
      "Fetch Repositories",
    );
  }
}
