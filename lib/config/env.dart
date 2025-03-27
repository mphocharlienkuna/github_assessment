import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Loads environment variables from `.env`.
class Env {
  /// GitHub personal access token.
  static String get githubToken => dotenv.env['GITHUB_TOKEN'] ?? '';
}
