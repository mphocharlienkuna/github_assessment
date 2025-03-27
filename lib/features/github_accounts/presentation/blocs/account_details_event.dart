/// Base class for all account detail-related events.
abstract class AccountDetailsEvent {
  const AccountDetailsEvent();
}

/// Event to trigger loading of user details and repositories by [username].
class LoadAccountDetails extends AccountDetailsEvent {
  final String username;

  const LoadAccountDetails(this.username);
}
