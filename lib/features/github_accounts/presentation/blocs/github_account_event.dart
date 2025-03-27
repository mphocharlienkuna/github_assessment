import 'package:equatable/equatable.dart';

/// Base class for all GitHub account-related events.
abstract class GitHubAccountEvent extends Equatable {
  const GitHubAccountEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load liked GitHub accounts from local storage.
class LoadLikedAccounts extends GitHubAccountEvent {}

/// Event to search GitHub users by a [query] string.
class SearchGitHubUsers extends GitHubAccountEvent {
  final String query;

  const SearchGitHubUsers(this.query);

  @override
  List<Object?> get props => [query];
}

/// Event to like a GitHub account with [username] and [accountData].
class LikeGitHubAccount extends GitHubAccountEvent {
  final String username;
  final Map<String, dynamic> accountData;

  const LikeGitHubAccount(this.username, this.accountData);

  @override
  List<Object?> get props => [username, accountData];
}

/// Event to unlike a GitHub account with [username].
class UnlikeGitHubAccount extends GitHubAccountEvent {
  final String username;

  const UnlikeGitHubAccount(this.username);

  @override
  List<Object?> get props => [username];
}
