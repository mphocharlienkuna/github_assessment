import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/repositories/github_account_repository_impl.dart';
import '../../data/services/github_api_service.dart';
import '../../domain/usecases/get_user_details.dart';
import '../../domain/usecases/get_user_repositories.dart';
import '../blocs/account_details_bloc.dart';
import '../blocs/account_details_event.dart';
import '../blocs/account_details_state.dart';
import '../../../../core/utils/date_util.dart';

/// Displays detailed info about a GitHub user and their repositories.
class AccountDetailsScreen extends StatelessWidget {
  final String username;

  const AccountDetailsScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final repository = GitHubAccountRepositoryImpl(
      GitHubApiService(DioProvider.createDio()),
    );

    return BlocProvider(
      create: (_) => AccountDetailsBloc(
        getUserDetails: GetUserDetails(repository),
        getUserRepositories: GetUserRepositories(repository),
      )..add(LoadAccountDetails(username)),
      child: Scaffold(
        appBar: AppBar(title: Text(username)),
        body: BlocBuilder<AccountDetailsBloc, AccountDetailsState>(
          builder: (context, state) {
            if (state is AccountDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AccountDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is AccountDetailsLoaded) {
              return Column(
                children: [
                  _buildUserInfo(state.user),
                  const Divider(),
                  Expanded(child: _buildRepoList(state.repositories)),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  /// Builds user profile info (name, avatar, bio, stats).
  Widget _buildUserInfo(user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.avatarUrl),
            onBackgroundImageError: (exception, stackTrace) {
              debugPrint("Error loading image: $exception");
            },
          ),
          const SizedBox(height: 8),
          Text(user.name ?? '', style: const TextStyle(fontSize: 18)),
          Text('@${user.login}', style: const TextStyle(color: Colors.grey)),
          if (user.bio != null) ...[
            const SizedBox(height: 8),
            Text(user.bio!, textAlign: TextAlign.center),
          ],
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            children: [
              Text('Repos: ${user.publicRepos}'),
              Text('Gists: ${user.publicGists}'),
              Text('Followers: ${user.followers}'),
              Text('Following: ${user.following}'),
            ],
          ),
          const SizedBox(height: 8),
          Text('Joined: ${DateUtil.formatDate(user.createdAt)}'),
        ],
      ),
    );
  }

  /// Builds list of repositories with details.
  Widget _buildRepoList(List repos) {
    return ListView.separated(
      itemCount: repos.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final repo = repos[index];
        return ListTile(
          title: Text(repo.name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (repo.description != null)
                Text(repo.description!,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 8),
              Text('Created: ${DateUtil.formatDate(repo.createdAt)}'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  if (repo.language != null) Text(repo.language!),
                  Text('⭐ ${repo.stargazersCount}'),
                  Text('🍴 ${repo.forksCount}'),
                  Text('👁 ${repo.watchersCount}'),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: repo.htmlUrl));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Repo URL copied!")),
              );
            },
          ),
        );
      },
    );
  }
}
