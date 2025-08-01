class ItemModel {
  int id;
  String title;
  String imgUrl;
  String opinion;
  String myRating;
  String category;

  ItemModel(
      {this.id = 0,
      required this.title,
      required this.imgUrl,
      required this.opinion,
      required this.myRating,
      required this.category
      });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
        id: map['id'],
        title: map['title'],
        imgUrl: map['imgUrl'],
        opinion: map['opinion'],
        myRating: map['myRating'],
        category: map['category'] ?? '',
    );
  }
}
