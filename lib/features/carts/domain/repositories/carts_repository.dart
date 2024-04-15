import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';

abstract class CartsRepository {
  Future<List<Cart>> getCarts(int limit);
}
