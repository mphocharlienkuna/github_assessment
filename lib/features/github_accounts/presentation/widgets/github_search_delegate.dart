import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/constants/app_constants.dart';
import '../blocs/github_account_event.dart';
import '../blocs/github_account_bloc.dart';

/// A custom search delegate for searching GitHub users.
///
/// This delegate handles displaying search results, suggesting recent searches,
/// and managing actions like clearing the search query or going back.
/// It uses [Hive] to store recent searches and the [GitHubAccountBloc] to fetch users.
///
/// [query] - The search query input by the user.
class GitHubSearchDelegate extends SearchDelegate<String> {
  final Box _recentBox = Hive.box(AppConstants.recentSearchesBox);

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query = '',
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''),
      );

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) return const SizedBox();

    _recentBox.put(query, query);

    context.read<GitHubAccountBloc>().add(SearchGitHubUsers(query));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      close(context, query);
    });

    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _recentBox.values
        .where((e) => e.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return suggestions.isEmpty
        ? const Center(child: Text("No recent searches."))
        : ListView.builder(
            itemCount: suggestions.length,
            itemBuilder: (_, index) {
              final suggestion = suggestions[index];
              return ListTile(
                title: Text(suggestion),
                onTap: () {
                  query = suggestion;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showResults(context);
                  });
                },
              );
            },
          );
  }
}
