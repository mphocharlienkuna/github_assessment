import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../blocs/github_account_bloc.dart';
import '../blocs/github_account_state.dart';
import '../widgets/empty_state.dart';
import '../widgets/github_search_delegate.dart';
import '../widgets/liked_accounts.dart';
import '../widgets/search_results.dart';

/// The home screen of the GitHub app that displays:
/// - Liked GitHub accounts (from local storage)
/// - Search results for GitHub users
/// - An empty state when no liked accounts or search results are found
///
/// The screen allows users to search for GitHub users, view liked accounts,
/// and display relevant data based on the current app state (loading, error, etc.).
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GitHub Accounts")),
      body: FutureBuilder(
        future: _initializeHive(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return ValueListenableBuilder(
            valueListenable:
                Hive.box(AppConstants.likedAccountsBox).listenable(),
            builder: (context, Box likedBox, _) {
              return BlocBuilder<GitHubAccountBloc, GitHubAccountState>(
                builder: (context, state) {
                  List<Map<String, dynamic>> likedAccounts = [];
                  List<dynamic> searchResults = [];

                  if (state is GitHubLikedAccountsLoaded) {
                    likedAccounts = state.likedAccounts;
                  } else if (state is GitHubAccountSearchResults) {
                    searchResults = state.accounts;
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LikedAccounts(likedAccounts: likedAccounts),
                        SearchResults(searchResults: searchResults),
                        if (likedAccounts.isEmpty && searchResults.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: EmptyState(state: state),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showSearch(
              context: context,
              delegate: GitHubSearchDelegate(),
            );
          });
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  /// Initializes the Hive database and opens the necessary boxes.
  Future<void> _initializeHive() async {
    await Hive.initFlutter();
    await Hive.openBox(AppConstants.likedAccountsBox);
    await Hive.openBox(AppConstants.recentSearchesBox);
  }
}
