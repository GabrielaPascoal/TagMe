import 'package:myfavsdb/src/models/item_model.dart';

ItemModel filme1 = ItemModel(
  title: 'Procurando Nemo',
  imgUrl: 'assets/movies/procurando-nemo.jpg',
  opinion: 'Ótimo filme para assistir com os amigos.', myRating: '', category: '',
);

ItemModel filme2 = ItemModel(
  title: 'Batman',
  imgUrl: 'assets/movies/batman.jpeg',
  opinion: 'Ótimo filme para assistir com os amigos.', myRating: '', category: '',
);

ItemModel filme3 = ItemModel(
  title: 'Meninas Malvadas',
  imgUrl: 'assets/movies/meninas-malvadas.jpg',
  opinion: 'Ótimo filme para assistir com os amigos.', myRating: '', category: '',
);

ItemModel filme4 = ItemModel(
  title: 'Entre Facas e Segredos',
  imgUrl: 'assets/movies/entrefacasesegredos.jpeg',
  opinion: 'Ótimo filme para assistir com os amigos.', myRating: '', category: '',
);

List<ItemModel> items = [
  filme1,filme2,filme3,filme4
];

List<String> categories = [
  'Movies',
  'Series',
  'Albums',
  'Books',
  'Games'
];