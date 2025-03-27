import '../../domain/entities/github_account_entity.dart';

/// Data transfer object for GitHub account API response.
class GitHubAccountDTO {
  final String login;
  final String avatarUrl;
  final String type;

  GitHubAccountDTO({
    required this.login,
    required this.avatarUrl,
    required this.type,
  });

  /// Creates a [GitHubAccountDTO] from JSON.
  factory GitHubAccountDTO.fromJson(Map<String, dynamic> json) =>
      GitHubAccountDTO(
        login: json['login'],
        avatarUrl: json['avatar_url'],
        type: json['type'],
      );

  /// Converts this DTO into a domain entity.
  GitHubAccountEntity toEntity() => GitHubAccountEntity(
        login: login,
        avatarUrl: avatarUrl,
        type: type,
      );
}
