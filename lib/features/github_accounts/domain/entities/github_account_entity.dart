/// Domain entity representing a basic GitHub account.
class GitHubAccountEntity {
  final String login;
  final String avatarUrl;
  final String type;

  GitHubAccountEntity({
    required this.login,
    required this.avatarUrl,
    required this.type,
  });
}
