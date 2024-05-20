class Product {
  final String name;
final String imageurl;
  Product({
    required this.name,
    required this.imageurl
  });

  // ignore: recursive_getters
  bool get isFavorite => isFavorite;


  set isFavorite(bool isFavorite) {}
}
