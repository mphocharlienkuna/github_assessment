import 'package:flutter/material.dart';
import '../blocs/github_account_state.dart';

/// A widget to display an empty state for GitHub account searches.
///
/// This widget shows different states based on the [GitHubAccountState]:
/// - [GitHubAccountLoading]: Displays a loading indicator.
/// - [GitHubAccountError]: Displays an error message.
/// - Default: Displays a message prompting the user to start searching for GitHub users.
class EmptyState extends StatelessWidget {
  final GitHubAccountState state;

  const EmptyState({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    if (state is GitHubAccountLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is GitHubAccountError) {
      final errorState = state as GitHubAccountError;
      return Center(child: Text(errorState.message));
    }

    return const Center(child: Text('Start by searching for GitHub users.'));
  }
}
