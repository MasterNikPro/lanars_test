class UnsplashImage {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int width;
  final int height;
  final String color;
  final String blurHash;
  final int likes;
  final bool likedByUser;
  final String description;
  final User user;
  final List<Collection> currentUserCollections;
  final Urls urls;
  final Links links;

  UnsplashImage({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.likes,
    required this.likedByUser,
    required this.description,
    required this.user,
    required this.currentUserCollections,
    required this.urls,
    required this.links,
  });

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      width: json['width'],
      height: json['height'],
      color: json['color'],
      blurHash: json['blur_hash'],
      likes: json['likes'],
      likedByUser: json['liked_by_user'],
      description: json['description'],
      user: User.fromJson(json['user']),
      currentUserCollections: (json['current_user_collections'] as List)
          .map((collection) => Collection.fromJson(collection))
          .toList(),
      urls: Urls.fromJson(json['urls']),
      links: Links.fromJson(json['links']),
    );
  }
}
class Collection {
  int? id;
  String? title;
  DateTime? publishedAt;
  DateTime? lastCollectedAt;
  DateTime? updatedAt;
  UnsplashImage? unsplashImage;
  User? user;

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    publishedAt = DateTime.parse(json['published_at']);
    lastCollectedAt = DateTime.parse(json['last_collected_at']);
    updatedAt = DateTime.parse(json['updated_at']);
    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }
  }
}

class User {
  String? id;
  String? username;
  String? name;
  String? portfolioUrl;
  String? bio;
  String? location;
  int? totalLikes;
  int? totalPhotos;
  int? totalCollections;
  String? instagramUsername;
  String? twitterUsername;
  ProfileImage? profileImage;
  UserLinks? userLinks;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    portfolioUrl = json['portfolio_url'];
    bio = json['bio'];
    location = json['location'];
    totalLikes = json['total_likes'];
    totalPhotos = json['total_photos'];
    totalCollections = json['total_collections'];
    instagramUsername = json['instagram_username'];
    twitterUsername = json['twitter_username'];
    profileImage = ProfileImage.fromJson(json['profile_image']);
    userLinks = UserLinks.fromJson(json['links']);
  }
}

class ProfileImage {
  final String small;
  final String medium;
  final String large;

  ProfileImage({
    required this.small,
    required this.medium,
    required this.large,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) {
    return ProfileImage(
      small: json['small'],
      medium: json['medium'],
      large: json['large'],
    );
  }
}

class UserLinks {
  final String self;
  final String html;
  final String photos;
  final String likes;
  final String portfolio;

  UserLinks({
    required this.self,
    required this.html,
    required this.photos,
    required this.likes,
    required this.portfolio,
  });

  factory UserLinks.fromJson(Map<String, dynamic> json) {
    return UserLinks(
      self: json['self'],
      html: json['html'],
      photos: json['photos'],
      likes: json['likes'],
      portfolio: json['portfolio'],
    );
  }
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
  });

  factory Urls.fromJson(Map<String, dynamic> json) {
    return Urls(
      raw: json['raw'],
      full: json['full'],
      regular: json['regular'],
      small: json['small'],
      thumb: json['thumb'],
    );
  }
}

class Links {
  String self;
  String html;
  String download;
  String downloadLocation;

  Links({
    required this.self,
    required this.html,
    required this.download,
    required this.downloadLocation,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: json['self'],
      html: json['html'],
      download: json['download'],
      downloadLocation: json['download_location'],
    );
  }
}
