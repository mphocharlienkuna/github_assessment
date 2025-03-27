/// Domain entity representing detailed information about a GitHub user.
class GitHubUserDetailsEntity {
  final String login;
  final String? name;
  final String avatarUrl;
  final String? bio;
  final int publicRepos;
  final int publicGists;
  final int followers;
  final int following;
  final String createdAt;

  GitHubUserDetailsEntity({
    required this.login,
    this.name,
    required this.avatarUrl,
    this.bio,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    required this.createdAt,
  });
}
