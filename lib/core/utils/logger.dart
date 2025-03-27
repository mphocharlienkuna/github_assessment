import 'package:flutter/cupertino.dart';

/// Logs a message to the console with a '[AppLog]' prefix for easy identification.
///
/// This utility function is helpful for consistent logging across the application.
void appLog(String message) {
  debugPrint('[AppLog] $message');
}
