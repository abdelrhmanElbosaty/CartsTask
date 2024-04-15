import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';
import 'package:carts_task/features/carts/domain/repositories/carts_repository.dart';

class CartsUseCase {
  final CartsRepository repository;

  CartsUseCase(this.repository);

  Future<List<Cart>> execute(int limit) async {
    return await repository.getCarts(limit);
  }
}
