import 'package:equatable/equatable.dart';

/// Base class for all GitHub account-related states.
abstract class GitHubAccountState extends Equatable {
  const GitHubAccountState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action is taken.
class GitHubAccountInitial extends GitHubAccountState {}

/// State when loading data (e.g. searching users).
class GitHubAccountLoading extends GitHubAccountState {}

/// State representing search results with a list of GitHub accounts.
class GitHubAccountSearchResults extends GitHubAccountState {
  final List<dynamic> accounts;

  const GitHubAccountSearchResults(this.accounts);

  @override
  List<Object?> get props => [accounts];
}

/// State representing locally liked GitHub accounts.
class GitHubLikedAccountsLoaded extends GitHubAccountState {
  final List<Map<String, dynamic>> likedAccounts;

  const GitHubLikedAccountsLoaded(this.likedAccounts);

  @override
  List<Object?> get props => [likedAccounts];
}

/// State representing an error with a message.
class GitHubAccountError extends GitHubAccountState {
  final String message;

  const GitHubAccountError(this.message);

  @override
  List<Object?> get props => [message];
}
