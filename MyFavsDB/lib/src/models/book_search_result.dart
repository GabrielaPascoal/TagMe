class BookSearchResult {
  final String id;
  final VolumeInfo volumeInfo;
  final SearchInfo? searchInfo;

  BookSearchResult({
    required this.id,
    required this.volumeInfo,
    this.searchInfo,
  });

  factory BookSearchResult.fromMap(Map<String, dynamic> map) {
    return BookSearchResult(
      id: map['id'] ?? '',
      volumeInfo: VolumeInfo.fromMap(map['volumeInfo'] ?? {}),
      searchInfo: map['searchInfo'] != null 
          ? SearchInfo.fromMap(map['searchInfo']) 
          : null,
    );
  }

  String get title => volumeInfo.title;
  String get authors => volumeInfo.authors.join(', ');
  String get description => volumeInfo.description;
  String get imageUrl => volumeInfo.imageLinks?.thumbnail ?? '';
  String get publishedDate => volumeInfo.publishedDate;
  String get isbn => volumeInfo.isbn;
  String get rating => volumeInfo.displayRating;
  String get categories => volumeInfo.categories.join(', ');
}

class VolumeInfo {
  final String title;
  final List<String> authors;
  final String description;
  final String publishedDate;
  final ImageLinks? imageLinks;
  final List<IndustryIdentifier> industryIdentifiers;
  final double averageRating;
  final int ratingsCount;
  final List<String> categories;
  final int pageCount;
  final String language;

  VolumeInfo({
    required this.title,
    required this.authors,
    required this.description,
    required this.publishedDate,
    this.imageLinks,
    required this.industryIdentifiers,
    required this.averageRating,
    required this.ratingsCount,
    required this.categories,
    required this.pageCount,
    required this.language,
  });

  factory VolumeInfo.fromMap(Map<String, dynamic> map) {
    return VolumeInfo(
      title: map['title'] ?? '',
      authors: List<String>.from(map['authors'] ?? []),
      description: map['description'] ?? '',
      publishedDate: map['publishedDate'] ?? '',
      imageLinks: map['imageLinks'] != null 
          ? ImageLinks.fromMap(map['imageLinks']) 
          : null,
      industryIdentifiers: (map['industryIdentifiers'] as List<dynamic>?)
          ?.map((id) => IndustryIdentifier.fromMap(id))
          .toList() ?? [],
      averageRating: (map['averageRating'] ?? 0.0).toDouble(),
      ratingsCount: map['ratingsCount'] ?? 0,
      categories: List<String>.from(map['categories'] ?? []),
      pageCount: map['pageCount'] ?? 0,
      language: map['language'] ?? '',
    );
  }

  String get isbn {
    final isbn13 = industryIdentifiers
        .where((id) => id.type == 'ISBN_13')
        .firstOrNull;
    if (isbn13 != null) return isbn13.identifier;
    
    final isbn10 = industryIdentifiers
        .where((id) => id.type == 'ISBN_10')
        .firstOrNull;
    return isbn10?.identifier ?? '';
  }

  String get displayRating => averageRating > 0 ? averageRating.toStringAsFixed(1) : 'N/A';
}

class ImageLinks {
  final String smallThumbnail;
  final String thumbnail;

  ImageLinks({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  factory ImageLinks.fromMap(Map<String, dynamic> map) {
    return ImageLinks(
      smallThumbnail: map['smallThumbnail'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
    );
  }
}

class IndustryIdentifier {
  final String type;
  final String identifier;

  IndustryIdentifier({
    required this.type,
    required this.identifier,
  });

  factory IndustryIdentifier.fromMap(Map<String, dynamic> map) {
    return IndustryIdentifier(
      type: map['type'] ?? '',
      identifier: map['identifier'] ?? '',
    );
  }
}

class SearchInfo {
  final String textSnippet;

  SearchInfo({required this.textSnippet});

  factory SearchInfo.fromMap(Map<String, dynamic> map) {
    return SearchInfo(
      textSnippet: map['textSnippet'] ?? '',
    );
  }
} 