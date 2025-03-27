import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../blocs/github_account_bloc.dart';
import '../blocs/github_account_event.dart';
import '../screens/account_details_screen.dart';

/// A reusable list tile widget that displays a GitHub account's information.
///
/// The [AccountTile] widget shows the account's login, avatar, type, and
/// supports liking/unliking accounts. It also provides navigation to the
/// account details screen when tapped.
///
/// The tile listens to the Hive box for liked accounts and updates the UI
/// based on whether the account is liked or not. When the like/unlike button
/// is pressed, the [GitHubAccountBloc] is used to update the state accordingly.
class AccountTile extends StatelessWidget {
  final String login;
  final String avatarUrl;
  final String type;
  final Map<String, dynamic>? rawData;

  const AccountTile({
    super.key,
    required this.login,
    required this.avatarUrl,
    required this.type,
    this.rawData,
  });

  /// Checks if the account is liked by checking if the [login] exists in the Hive box.
  bool _isLiked(Box box) => box.containsKey(login);

  /// Handles the like/unlike toggle action by dispatching the corresponding event
  /// to the [GitHubAccountBloc].
  void _handleLikeToggle(BuildContext context, bool isLiked) {
    final bloc = context.read<GitHubAccountBloc>();
    if (isLiked) {
      bloc.add(UnlikeGitHubAccount(login));
    } else if (rawData != null) {
      bloc.add(LikeGitHubAccount(login, rawData!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(AppConstants.likedAccountsBox).listenable(),
      builder: (context, Box likedBox, _) {
        final isLiked = _isLiked(likedBox);

        return ListTile(
          key: ValueKey('account_tile_$login'),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
            onBackgroundImageError: (exception, stackTrace) {
              debugPrint("Error loading image: $exception");
            },
          ),
          title: Text(login),
          subtitle: Text(type),
          trailing: Tooltip(
            message: isLiked ? 'Unlike account' : 'Like account',
            child: Semantics(
              label: isLiked ? 'Unlike account' : 'Like account',
              button: true,
              child: IconButton(
                key: ValueKey('like_button_$login'),
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : null,
                ),
                onPressed: () => _handleLikeToggle(context, isLiked),
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AccountDetailsScreen(username: login),
              ),
            );
          },
        );
      },
    );
  }
}
