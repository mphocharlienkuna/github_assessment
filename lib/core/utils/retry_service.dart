import 'dart:async';

/// A service that provides retry functionality for asynchronous actions.
///
/// The [retry] method attempts to execute the provided action multiple times
/// (default is 3 retries), with a delay between attempts. If all retries fail,
/// an exception is thrown.
///
/// Example usage:
/// ```dart
/// await RetryService.retry(action: () async {
///   return await someAsyncFunction();
/// });
/// ```
class RetryService {
  /// Retries an asynchronous action multiple times before failing.
  ///
  /// [action] is the asynchronous function to execute.
  /// [retries] is the number of retry attempts (default is 3).
  /// [delay] is the time delay between retries (default is 2 seconds).
  ///
  /// Returns the result of the action on success.
  /// Throws an exception if all retries fail.
  static Future<T> retry<T>({
    required Future<T> Function() action,
    int retries = 3,
    Duration delay = const Duration(seconds: 2),
  }) async {
    for (int i = 0; i < retries; i++) {
      try {
        return await action();
      } catch (e) {
        if (i == retries - 1) {
          rethrow;
        }
        await Future.delayed(delay);
      }
    }
    throw Exception('Failed after $retries attempts');
  }
}
