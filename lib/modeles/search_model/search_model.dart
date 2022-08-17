class SearchModel {
  late bool status;
  late SearchData searchData;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    searchData = SearchData.fromJson(json['data']);
  }
}

class SearchData {
  late List<Product> productsData = [];

  SearchData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      productsData.add(Product.fromJson(element));
    });
  }
}

class Product {
  late int id;
  late dynamic price;
  late String image;
  late String name;
  late String description;
  late bool inFavorites;
  late bool inCart;
  late List<String> images = [];

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    json['images'].forEach((element) {
      images.add(element);
    });
  }
}
