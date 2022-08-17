class CartModel {
  bool? status;
  CartDetails? cartDetails;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    cartDetails = CartDetails.fromJson(json['data']);
  }
}

class CartDetails {
  List<CartItems> cartItems = [];

  dynamic total;

  dynamic subTotal;

  CartDetails.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    subTotal = json['sub_total'];

    json['cart_items'].forEach((element) {
      cartItems.add(CartItems.fromJson(element));
    });
  }
}

class CartItems {
  dynamic quantity;

  int? id;
  ProductData? product;

  CartItems.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    id = json['id'];
    product = ProductData.fromJson(json['product']);
  }
}

class ProductData {
  bool? inCart;
  bool? inFavorites;
  String? description;
  String? name;
  String? image;
  dynamic discount;
  dynamic oldPrice;
  dynamic price;
  int? id;

  ProductData.fromJson(Map<String, dynamic> json) {
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    description = json['description'];
    name = json['name'];
    discount = json['discount'];
    oldPrice = json['old_price'];
    price = json['price'];
    id = json['id'];
    image = json['image'];
  }
}
