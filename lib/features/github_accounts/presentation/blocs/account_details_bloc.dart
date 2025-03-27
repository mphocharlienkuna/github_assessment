import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/retry_service.dart';
import '../../domain/usecases/get_user_details.dart';
import '../../domain/usecases/get_user_repositories.dart';
import 'account_details_event.dart';
import 'account_details_state.dart';

/// BLoC that handles loading user details and repositories for a specific GitHub user.
///
/// This BLoC listens to the [LoadAccountDetails] event and retrieves the user's
/// details and repositories. It uses the [RetryService] to retry the action in case
/// of a failure and emits either [AccountDetailsLoaded] or [AccountDetailsError] state.
class AccountDetailsBloc
    extends Bloc<AccountDetailsEvent, AccountDetailsState> {
  final GetUserDetails getUserDetails;
  final GetUserRepositories getUserRepositories;

  /// Creates an instance of [AccountDetailsBloc] with [getUserDetails] and [getUserRepositories] use cases.
  AccountDetailsBloc({
    required this.getUserDetails,
    required this.getUserRepositories,
  }) : super(AccountDetailsInitial()) {
    on<LoadAccountDetails>(_onLoadAccountDetails);
  }

  /// Loads the user details and repositories by calling the [getUserDetails] and [getUserRepositories] use cases with retry functionality.
  ///
  /// If successful, it emits an [AccountDetailsLoaded] state with the user and repositories data.
  /// If any errors occur, it emits an [AccountDetailsError] state.
  Future<void> _onLoadAccountDetails(
      LoadAccountDetails event, Emitter<AccountDetailsState> emit) async {
    emit(AccountDetailsLoading());
    try {
      final user = await RetryService.retry(
        action: () => getUserDetails(event.username),
      );
      final repos = await RetryService.retry(
        action: () => getUserRepositories(event.username),
      );
      emit(AccountDetailsLoaded(user: user, repositories: repos));
    } catch (e) {
      appLog('Error loading account details for ${event.username}: $e');
      emit(AccountDetailsError(
          'We encountered an issue while fetching details for this user. Please try again later.'));
    }
  }
}
