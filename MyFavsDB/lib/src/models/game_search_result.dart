class GameSearchResult {
  final int id;
  final String name;
  final String released;
  final String backgroundImage;
  final double rating;
  final int ratingTop;
  final int metacritic;
  final String description;
  final List<GameGenre> genres;
  final List<GamePlatform> platforms;
  final List<GamePublisher> publishers;
  final List<GameDeveloper> developers;

  GameSearchResult({
    required this.id,
    required this.name,
    required this.released,
    required this.backgroundImage,
    required this.rating,
    required this.ratingTop,
    required this.metacritic,
    required this.description,
    required this.genres,
    required this.platforms,
    required this.publishers,
    required this.developers,
  });

  factory GameSearchResult.fromMap(Map<String, dynamic> map) {
    return GameSearchResult(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      released: map['released'] ?? '',
      backgroundImage: map['background_image'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      ratingTop: map['rating_top'] ?? 0,
      metacritic: map['metacritic'] ?? 0,
      description: map['description'] ?? '',
      genres: (map['genres'] as List<dynamic>?)
          ?.map((genre) => GameGenre.fromMap(genre))
          .toList() ?? [],
      platforms: (map['platforms'] as List<dynamic>?)
          ?.map((platform) => GamePlatform.fromMap(platform))
          .toList() ?? [],
      publishers: (map['publishers'] as List<dynamic>?)
          ?.map((publisher) => GamePublisher.fromMap(publisher))
          .toList() ?? [],
      developers: (map['developers'] as List<dynamic>?)
          ?.map((developer) => GameDeveloper.fromMap(developer))
          .toList() ?? [],
    );
  }

  String get displayRating => rating > 0 ? rating.toStringAsFixed(1) : 'N/A';
  String get displayMetacritic => metacritic > 0 ? metacritic.toString() : 'N/A';
  String get displayGenres => genres.take(3).map((g) => g.name).join(', ');
  String get displayPlatforms => platforms.take(3).map((p) => p.platform.name).join(', ');
}

class GameGenre {
  final int id;
  final String name;

  GameGenre({required this.id, required this.name});

  factory GameGenre.fromMap(Map<String, dynamic> map) {
    return GameGenre(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }
}

class GamePlatform {
  final PlatformInfo platform;

  GamePlatform({required this.platform});

  factory GamePlatform.fromMap(Map<String, dynamic> map) {
    return GamePlatform(
      platform: PlatformInfo.fromMap(map['platform'] ?? {}),
    );
  }
}

class PlatformInfo {
  final int id;
  final String name;

  PlatformInfo({required this.id, required this.name});

  factory PlatformInfo.fromMap(Map<String, dynamic> map) {
    return PlatformInfo(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }
}

class GamePublisher {
  final int id;
  final String name;

  GamePublisher({required this.id, required this.name});

  factory GamePublisher.fromMap(Map<String, dynamic> map) {
    return GamePublisher(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }
}

class GameDeveloper {
  final int id;
  final String name;

  GameDeveloper({required this.id, required this.name});

  factory GameDeveloper.fromMap(Map<String, dynamic> map) {
    return GameDeveloper(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }
} 