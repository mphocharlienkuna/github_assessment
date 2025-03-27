import '../entities/github_account_entity.dart';
import '../repositories/github_account_repository.dart';

/// Use case for searching GitHub accounts by query.
class SearchAccounts {
  final GitHubAccountRepository repository;

  SearchAccounts(this.repository);

  /// Executes the use case with the given [query].
  Future<List<GitHubAccountEntity>> call(String query) {
    return repository.searchAccounts(query);
  }
}
