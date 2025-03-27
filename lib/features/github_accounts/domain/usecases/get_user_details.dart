import '../entities/github_user_details_entity.dart';
import '../repositories/github_account_repository.dart';

/// Use case for retrieving GitHub user details.
class GetUserDetails {
  final GitHubAccountRepository repository;

  GetUserDetails(this.repository);

  /// Executes the use case with the given [username].
  Future<GitHubUserDetailsEntity> call(String username) {
    return repository.getUserDetails(username);
  }
}
