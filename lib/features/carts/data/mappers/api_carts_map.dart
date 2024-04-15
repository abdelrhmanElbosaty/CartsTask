import 'package:carts_task/features/carts/data/models/api_carts_result.dart';
import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';
import 'package:uuid/uuid.dart';

extension ConvertApiCartsResult on ApiCart {
  Cart get mapCart {
    return Cart(
      id: id.toString(),
      products: products?.map((e) => e.mapProduct).toList(),
    );
  }
}

extension ConvertApiProductResult on ApiProduct {
  Product get mapProduct {
    return Product(
      id: const Uuid().v4(),
      title: title,
      price: price,
      thumbnail: thumbnail,
    );
  }
}
