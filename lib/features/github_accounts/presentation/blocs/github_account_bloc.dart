import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/retry_service.dart';
import '../../domain/usecases/search_accounts.dart';
import 'github_account_event.dart';
import 'github_account_state.dart';

/// BLoC that handles GitHub account search, likes, and caching.
///
/// This BLoC listens to various events like searching for GitHub users,
/// loading liked accounts, and liking or unliking accounts. It interacts
/// with the Hive database to store liked accounts and uses the [RetryService]
/// to retry failed actions.
class GitHubAccountBloc extends Bloc<GitHubAccountEvent, GitHubAccountState> {
  final SearchAccounts searchAccounts;
  final Box likedBox = Hive.box(AppConstants.likedAccountsBox);

  /// Constructor for the [GitHubAccountBloc], initializing event handlers.
  GitHubAccountBloc({
    required this.searchAccounts,
  }) : super(GitHubAccountInitial()) {
    on<SearchGitHubUsers>(
        (event, emit) => _handleSearchGitHubUsers(event.query, emit));
    on<LoadLikedAccounts>((event, emit) => _handleLoadLikedAccounts(emit));
    on<LikeGitHubAccount>((event, emit) =>
        _handleLikeGitHubAccount(event.username, event.accountData, emit));
    on<UnlikeGitHubAccount>(
        (event, emit) => _handleUnlikeGitHubAccount(event.username, emit));
  }

  /// Handles searching for GitHub users with retry functionality.
  /// Sorts the search results based on whether they are liked or not.
  ///
  /// Emits either a [GitHubAccountSearchResults] state with the search results
  /// or a [GitHubAccountError] state if an error occurs.
  Future<void> _handleSearchGitHubUsers(
      String query, Emitter<GitHubAccountState> emit) async {
    emit(GitHubAccountLoading());
    try {
      final results = await RetryService.retry(
        action: () => searchAccounts(query),
      );

      // Sorting results by whether they are liked
      results.sort((a, b) {
        final isALiked = likedBox.containsKey(a.login);
        final isBLiked = likedBox.containsKey(b.login);

        if (isALiked && !isBLiked) {
          return -1;
        } else if (!isALiked && isBLiked) {
          return 1;
        } else {
          return 0;
        }
      });

      emit(GitHubAccountSearchResults(results));
    } catch (e) {
      appLog("Error searching users with query $query: $e");
      emit(GitHubAccountError(
          'We encountered a network error while searching for users. Please check your connection or try again later.'));
    }
  }

  /// Handles loading liked accounts from the Hive database.
  ///
  /// Emits a [GitHubLikedAccountsLoaded] state with the liked accounts
  /// or a [GitHubAccountError] state if an error occurs.
  Future<void> _handleLoadLikedAccounts(
      Emitter<GitHubAccountState> emit) async {
    try {
      final liked = likedBox.values
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
      emit(GitHubLikedAccountsLoaded(liked));
    } catch (e) {
      appLog("Error loading liked accounts: $e");
      emit(GitHubAccountError(
          'An error occurred while loading your liked accounts.'));
    }
  }

  /// Handles liking a GitHub account and updating the state accordingly.
  ///
  /// In case of an error, it emits a [GitHubAccountError] state.
  void _handleLikeGitHubAccount(String username,
      Map<String, dynamic> accountData, Emitter<GitHubAccountState> emit) {
    try {
      likedBox.put(username, accountData);
      _updateResultsState(emit);
    } catch (e) {
      appLog("Error liking account $username: $e");
      emit(GitHubAccountError('Unable to like the account. Please try again.'));
    }
  }

  /// Handles unliking a GitHub account and updating the state accordingly.
  ///
  /// In case of an error, it emits a [GitHubAccountError] state.
  void _handleUnlikeGitHubAccount(
      String username, Emitter<GitHubAccountState> emit) {
    try {
      likedBox.delete(username);
      _updateResultsState(emit);
    } catch (e) {
      appLog("Error unliking account $username: $e");
      emit(GitHubAccountError(
          'Unable to unlike the account. Please try again.'));
    }
  }

  /// A helper method to update the results state after liking or unliking an account.
  ///
  /// It either reloads the liked accounts or updates the search results.
  void _updateResultsState(Emitter<GitHubAccountState> emit) {
    if (state is GitHubAccountSearchResults) {
      final currentResults =
          List.from((state as GitHubAccountSearchResults).accounts);
      emit(GitHubAccountSearchResults(currentResults));
    } else {
      add(LoadLikedAccounts());
    }
  }
}
