import 'package:flutter/material.dart';
import '../features/github_accounts/presentation/screens/home_screen.dart';

/// Handles named route generation for the app.
class AppRouter {
  /// Returns the appropriate route based on [settings.name].
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
