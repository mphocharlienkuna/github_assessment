import '../../domain/entities/github_repository_entity.dart';
import '../../domain/entities/github_user_details_entity.dart';

/// Base class for all states related to account details.
abstract class AccountDetailsState {
  const AccountDetailsState();
}

/// State before any data is loaded.
class AccountDetailsInitial extends AccountDetailsState {}

/// State while user data and repositories are loading.
class AccountDetailsLoading extends AccountDetailsState {}

/// State when user details and repositories have been successfully loaded.
class AccountDetailsLoaded extends AccountDetailsState {
  final GitHubUserDetailsEntity user;
  final List<GitHubRepositoryEntity> repositories;

  const AccountDetailsLoaded({
    required this.user,
    required this.repositories,
  });
}

/// State when an error occurs during data loading.
class AccountDetailsError extends AccountDetailsState {
  final String message;

  const AccountDetailsError(this.message);
}
