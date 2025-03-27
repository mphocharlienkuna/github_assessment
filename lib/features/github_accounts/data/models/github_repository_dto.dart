import '../../domain/entities/github_repository_entity.dart';

/// DTO representing a GitHub repository from the API.
class GitHubRepositoryDTO {
  final String name;
  final String? description;
  final String createdAt;
  final String? language;
  final int stargazersCount;
  final int forksCount;
  final int watchersCount;
  final String htmlUrl;

  GitHubRepositoryDTO({
    required this.name,
    this.description,
    required this.createdAt,
    this.language,
    required this.stargazersCount,
    required this.forksCount,
    required this.watchersCount,
    required this.htmlUrl,
  });

  /// Creates a [GitHubRepositoryDTO] from JSON.
  factory GitHubRepositoryDTO.fromJson(Map<String, dynamic> json) =>
      GitHubRepositoryDTO(
        name: json['name'],
        description: json['description'],
        createdAt: json['created_at'],
        language: json['language'],
        stargazersCount: json['stargazers_count'],
        forksCount: json['forks_count'],
        watchersCount: json['watchers_count'],
        htmlUrl: json['html_url'],
      );

  /// Converts this DTO into a domain entity.
  GitHubRepositoryEntity toEntity() => GitHubRepositoryEntity(
        name: name,
        description: description,
        createdAt: createdAt,
        language: language,
        stargazersCount: stargazersCount,
        forksCount: forksCount,
        watchersCount: watchersCount,
        htmlUrl: htmlUrl,
      );
}
