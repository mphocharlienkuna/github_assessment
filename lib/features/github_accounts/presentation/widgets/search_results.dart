import 'package:flutter/cupertino.dart';
import 'account_tile.dart';

/// A widget that displays the search results as a list of `AccountTile` widgets.
///
/// This widget expects a list of search results where each result represents a GitHub account.
/// It displays the list with an optional title and each account in a tile format.
///
/// [searchResults] - List of search results to be displayed in tiles.
class SearchResults extends StatelessWidget {
  final List<dynamic> searchResults;

  const SearchResults({super.key, required this.searchResults});

  @override
  Widget build(BuildContext context) {
    if (searchResults.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🔍 Search Results',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...searchResults.map((account) => AccountTile(
                key: ValueKey(account.login),
                login: account.login,
                avatarUrl: account.avatarUrl,
                type: account.type,
                rawData: {
                  'login': account.login,
                  'avatar_url': account.avatarUrl,
                  'type': account.type,
                },
              )),
        ],
      ),
    );
  }
}
