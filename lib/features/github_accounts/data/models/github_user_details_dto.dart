import '../../domain/entities/github_user_details_entity.dart';

/// DTO representing detailed information about a GitHub user.
class GitHubUserDetailsDTO {
  final String login;
  final String? name;
  final String avatarUrl;
  final String? bio;
  final int publicRepos;
  final int publicGists;
  final int followers;
  final int following;
  final String createdAt;

  GitHubUserDetailsDTO({
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

  /// Creates a [GitHubUserDetailsDTO] from JSON data.
  factory GitHubUserDetailsDTO.fromJson(Map<String, dynamic> json) =>
      GitHubUserDetailsDTO(
        login: json['login'],
        name: json['name'],
        avatarUrl: json['avatar_url'],
        bio: json['bio'],
        publicRepos: json['public_repos'],
        publicGists: json['public_gists'],
        followers: json['followers'],
        following: json['following'],
        createdAt: json['created_at'],
      );

  /// Converts this DTO to a domain-level entity.
  GitHubUserDetailsEntity toEntity() => GitHubUserDetailsEntity(
        login: login,
        name: name,
        avatarUrl: avatarUrl,
        bio: bio,
        publicRepos: publicRepos,
        publicGists: publicGists,
        followers: followers,
        following: following,
        createdAt: createdAt,
      );
}
