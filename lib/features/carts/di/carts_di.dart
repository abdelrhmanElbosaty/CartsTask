import 'package:carts_task/features/carts/data/repositories_imp/carts_repository_imp.dart';
import 'package:carts_task/features/carts/domain/repositories/carts_repository.dart';
import 'package:carts_task/features/carts/domain/use_case/carts_use_case.dart';
import 'package:carts_task/features/core/app_injector.dart';

class CartsDi {
  CartsDi._();

  static Future<void> initialize() async {
    injector
        .registerLazySingleton<CartsRepository>(() => CartsRepositoryImpl());

    injector.registerFactory(() => CartsUseCase(injector()));
  }
}
