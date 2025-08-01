class AlbumSearchResult {
  final int collectionId;
  final String collectionName;
  final String artistName;
  final double collectionPrice;
  final String artworkUrl100;
  final String artworkUrl60;
  final String releaseDate;
  final int trackCount;
  final String primaryGenreName;
  final String collectionExplicitness;
  final String country;
  final String currency;
  final String collectionViewUrl;
  final String collectionCensoredName;
  final String artistViewUrl;
  final int artistId;
  final int? amgArtistId;
  final String copyright;
  final String description;

  AlbumSearchResult({
    required this.collectionId,
    required this.collectionName,
    required this.artistName,
    required this.collectionPrice,
    required this.artworkUrl100,
    required this.artworkUrl60,
    required this.releaseDate,
    required this.trackCount,
    required this.primaryGenreName,
    required this.collectionExplicitness,
    required this.country,
    required this.currency,
    required this.collectionViewUrl,
    required this.collectionCensoredName,
    required this.artistViewUrl,
    required this.artistId,
    this.amgArtistId,
    required this.copyright,
    required this.description,
  });

  factory AlbumSearchResult.fromMap(Map<String, dynamic> map) {
    return AlbumSearchResult(
      collectionId: map['collectionId'] ?? 0,
      collectionName: map['collectionName'] ?? '',
      artistName: map['artistName'] ?? '',
      collectionPrice: (map['collectionPrice'] ?? 0.0).toDouble(),
      artworkUrl100: map['artworkUrl100'] ?? '',
      artworkUrl60: map['artworkUrl60'] ?? '',
      releaseDate: map['releaseDate'] ?? '',
      trackCount: map['trackCount'] ?? 0,
      primaryGenreName: map['primaryGenreName'] ?? '',
      collectionExplicitness: map['collectionExplicitness'] ?? '',
      country: map['country'] ?? '',
      currency: map['currency'] ?? '',
      collectionViewUrl: map['collectionViewUrl'] ?? '',
      collectionCensoredName: map['collectionCensoredName'] ?? '',
      artistViewUrl: map['artistViewUrl'] ?? '',
      artistId: map['artistId'] ?? 0,
      amgArtistId: map['amgArtistId'],
      copyright: map['copyright'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String get fullImageUrl {
    if (artworkUrl100.isNotEmpty) {
      return artworkUrl100.replaceAll('100x100', '300x300');
    }
    return '';
  }

  String get displayPrice {
    if (collectionPrice > 0) {
      return '${collectionPrice.toStringAsFixed(2)} $currency';
    }
    return 'Gratuito';
  }

  String get displayReleaseDate {
    if (releaseDate.length >= 4) {
      return releaseDate.substring(0, 4);
    }
    return '';
  }

  String get displayTrackCount {
    return '$trackCount faixa${trackCount > 1 ? 's' : ''}';
  }
} 