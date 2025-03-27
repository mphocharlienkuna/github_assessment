import '../entities/github_account_entity.dart';
import '../entities/github_user_details_entity.dart';
import '../entities/github_repository_entity.dart';

/// Contract for interacting with GitHub account-related data.
abstract class GitHubAccountRepository {
  /// Searches GitHub accounts by username or keyword.
  Future<List<GitHubAccountEntity>> searchAccounts(String query);

  /// Fetches detailed information about a GitHub user.
  Future<GitHubUserDetailsEntity> getUserDetails(String username);

  /// Retrieves repositories for a specific GitHub user.
  Future<List<GitHubRepositoryEntity>> getUserRepositories(String username);
}
