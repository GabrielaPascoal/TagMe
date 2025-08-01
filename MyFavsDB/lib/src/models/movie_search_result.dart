class MovieSearchResult {
  final int id;
  final String? title;
  final String? name;
  final String? originalTitle;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final double? voteAverage;
  final String? releaseDate;
  final String? firstAirDate;

  MovieSearchResult({
    required this.id,
    this.title,
    this.name,
    this.originalTitle,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.voteAverage,
    this.releaseDate,
    this.firstAirDate,
  });

  factory MovieSearchResult.fromMap(Map<String, dynamic> json) {
    return MovieSearchResult(
      id: json['id'] ?? 0,
      title: json['title'],
      name: json['name'],
      originalTitle: json['original_title'],
      originalName: json['original_name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      mediaType: json['media_type'],
      voteAverage: json['vote_average']?.toDouble(),
      releaseDate: json['release_date'],
      firstAirDate: json['first_air_date'],
    );
  }

  String get displayTitle {
    return title ?? name ?? 'Sem título';
  }

  String get displayOriginalTitle {
    return originalTitle ?? originalName ?? '';
  }

  String get displayDate {
    return releaseDate ?? firstAirDate ?? '';
  }

  String? get fullPosterUrl {
    if (posterPath != null && posterPath!.isNotEmpty) {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
    return null;
  }

  String get mediaTypeDisplay {
    switch (mediaType) {
      case 'movie':
        return 'Filme';
      case 'tv':
        return 'Série';
      default:
        return mediaType ?? 'Desconhecido';
    }
  }
} 