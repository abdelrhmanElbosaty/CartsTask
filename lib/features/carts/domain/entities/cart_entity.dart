import 'package:equatable/equatable.dart';

class Cart extends Equatable {
  final String? id;
  final List<Product>? products;

  const Cart({
    this.id,
    this.products,
  });

  Cart modify({List<Product>? products}) {
    return Cart(
      id: id,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
        id,
        products,
      ];
}

class Product extends Equatable {
  final String? id;
  final String? title;
  final int? price;
  final String? thumbnail;
  final bool? isSelected;

  const Product({
    this.id,
    this.title,
    this.price,
    this.thumbnail,
    this.isSelected = false,
  });

  Product modify({bool? isSelected}) {
    return Product(
      thumbnail: thumbnail,
      price: price,
      id: id,
      title: title,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        thumbnail,
      ];
}
