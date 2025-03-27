/// Domain entity representing a GitHub repository.
class GitHubRepositoryEntity {
  final String name;
  final String? description;
  final String createdAt;
  final String? language;
  final int stargazersCount;
  final int forksCount;
  final int watchersCount;
  final String htmlUrl;

  GitHubRepositoryEntity({
    required this.name,
    this.description,
    required this.createdAt,
    this.language,
    required this.stargazersCount,
    required this.forksCount,
    required this.watchersCount,
    required this.htmlUrl,
  });
}
