import '../entities/github_repository_entity.dart';
import '../repositories/github_account_repository.dart';

/// Use case for retrieving a GitHub user's repositories.
class GetUserRepositories {
  final GitHubAccountRepository repository;

  GetUserRepositories(this.repository);

  /// Executes the use case with the given [username].
  Future<List<GitHubRepositoryEntity>> call(String username) {
    return repository.getUserRepositories(username);
  }
}
