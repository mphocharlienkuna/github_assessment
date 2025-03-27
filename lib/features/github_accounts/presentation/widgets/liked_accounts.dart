import 'package:flutter/cupertino.dart';
import 'account_tile.dart';

/// A widget that displays the list of liked GitHub accounts as `AccountTile` widgets.
///
/// This widget expects a list of liked accounts where each account is represented by a map of dynamic data.
/// It displays the list of liked accounts with a title and each account in a tile format.
///
/// [likedAccounts] - List of liked GitHub accounts to be displayed in tiles.
class LikedAccounts extends StatelessWidget {
  final List<Map<String, dynamic>> likedAccounts;

  const LikedAccounts({super.key, required this.likedAccounts});

  @override
  Widget build(BuildContext context) {
    if (likedAccounts.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('⭐ Liked Accounts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...likedAccounts.map((user) => AccountTile(
                key: ValueKey(user['login']),
                login: user['login'],
                avatarUrl: user['avatar_url'],
                type: user['type'],
                rawData: user,
              )),
        ],
      ),
    );
  }
}
