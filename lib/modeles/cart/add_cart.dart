class AddToCart {
  late bool status;
  InCartDetails? inCartDetails;

  AddToCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    inCartDetails = InCartDetails.fromJson(json['data']);
  }
}

class InCartDetails {
  late int inCartID;
  late int quantity;
  Product? product;

  InCartDetails.fromJson(Map<String, dynamic> json) {
    inCartID = json['id'];
    quantity = json['quantity'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}
