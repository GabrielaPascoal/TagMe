class UserSearchResult {
  final String email;
  final int totalItems;
  final int totalCategories;

  UserSearchResult({
    required this.email,
    required this.totalItems,
    required this.totalCategories,
  });

  factory UserSearchResult.fromMap(Map<String, dynamic> json) {
    return UserSearchResult(
      email: json['email'] ?? '',
      totalItems: json['totalItems'] ?? 0,
      totalCategories: json['totalCategories'] ?? 0,
    );
  }
}

class UserProfileResult {
  final String email;
  final List<UserProfileItem> items;
  final int totalItems;
  final int totalCategories;

  UserProfileResult({
    required this.email,
    required this.items,
    required this.totalItems,
    required this.totalCategories,
  });

  factory UserProfileResult.fromMap(Map<String, dynamic> json) {
    final List<UserProfileItem> itemsList = [];
    if (json['items'] != null) {
      for (var item in json['items']) {
        itemsList.add(UserProfileItem.fromMap(item));
      }
    }

    return UserProfileResult(
      email: json['email'] ?? '',
      items: itemsList,
      totalItems: json['totalItems'] ?? 0,
      totalCategories: json['totalCategories'] ?? 0,
    );
  }
}

class UserProfileItem {
  final int id;
  final String title;
  final String opinion;
  final String myRating;
  final String imgUrl;
  final String categoryName;
  final String categoryIcon;

  UserProfileItem({
    required this.id,
    required this.title,
    required this.opinion,
    required this.myRating,
    required this.imgUrl,
    required this.categoryName,
    required this.categoryIcon,
  });

  factory UserProfileItem.fromMap(Map<String, dynamic> json) {
    return UserProfileItem(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      opinion: json['opinion'] ?? '',
      myRating: json['myRating'] ?? '',
      imgUrl: json['imgUrl'] ?? '',
      categoryName: json['categoryName'] ?? '',
      categoryIcon: json['categoryIcon'] ?? '',
    );
  }
} 