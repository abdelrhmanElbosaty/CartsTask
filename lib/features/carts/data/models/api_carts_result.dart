class ApiCartsResult {
  List<ApiCart>? carts;

  ApiCartsResult({
    this.carts,
  });

  factory ApiCartsResult.fromJson(Map<String, dynamic> json) => ApiCartsResult(
        carts: json["carts"] == null
            ? []
            : List<ApiCart>.from(
                json["carts"]!.map((x) => ApiCart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "carts": carts == null
            ? []
            : List<dynamic>.from(carts!.map((x) => x.toJson())),
      };
}

class ApiCart {
  int? id;
  List<ApiProduct>? products;

  ApiCart({
    this.id,
    this.products,
  });

  factory ApiCart.fromJson(Map<String, dynamic> json) => ApiCart(
        id: json["id"],
        products: json["products"] == null
            ? []
            : List<ApiProduct>.from(
                json["products"]!.map((x) => ApiProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class ApiProduct {
  int? id;
  String? title;
  int? price;
  String? thumbnail;

  ApiProduct({
    this.id,
    this.title,
    this.price,
    this.thumbnail,
  });

  factory ApiProduct.fromJson(Map<String, dynamic> json) => ApiProduct(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "thumbnail": thumbnail,
      };
}
