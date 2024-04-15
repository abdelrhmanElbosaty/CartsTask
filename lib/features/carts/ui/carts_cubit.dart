import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';
import 'package:carts_task/features/carts/domain/use_case/carts_use_case.dart';
import 'package:carts_task/features/carts/utils/add_remove_product_subscription.dart';
import 'package:carts_task/features/core/app_injector.dart';
import 'package:carts_task/features/core/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  CartsCubit() : super(CartsInitial()) {
    _loadUseCases();
    _composite.add(
      AddRemoveProductSubscription.stream().listen(
        (event) {
          _updateProductSelection(event.product?.id ?? '', event.isAdded);
        },
      ),
    );
  }

  static CartsCubit of(context) => BlocProvider.of(context);

  late final CartsUseCase _cartsUseCase;
  final _composite = CompositeSubscription();

  void _loadUseCases() {
    _cartsUseCase = injector();
  }

  void onCubitStart() async {
    _getCartsData();
  }

  List<Cart> carts = [];
  List<Product> products = [];

  Future<void> getMoreCarts(int limit) async {
    final carts = await _cartsUseCase.execute(limit);
    this.carts.addAll(carts);
    emit(CartsLoaded(carts: this.carts, products: products));
  }

  Future<void> _getCartsData() async {
    emit(CartsLoading());
    try {
      final carts = await _cartsUseCase.execute(20);
      this.carts = carts;
      emit(CartsLoaded(carts: carts, products: products));
    } catch (e) {
      if (e is ApiRequestException) {
        emit(CartsError(e.errorMessage));
      }
    }
  }

  void addProduct(Product product) {
    products.add(product);
    AddRemoveProductSubscription.pushUpdate(product, true);
    emit(CartsLoaded(carts: carts, products: products));
  }

  void removeProduct(Product? product) {
    AddRemoveProductSubscription.pushUpdate(product, false);
    products.removeWhere((element) => element.id == product?.id);
    emit(CartsLoaded(carts: carts, products: products));
  }

  void _updateProductSelection(String productId, bool isSelected) {
    for (Cart cart in carts) {
      for (Product product in cart.products ?? []) {
        if (product.id == productId) {
          final updatedProduct = product.modify(isSelected: isSelected);
          cart.products?[cart.products!.indexOf(product)] = updatedProduct;
          break;
        }
      }
    }
    emit(CartsLoaded(carts: carts, products: products));
  }

  void searchByProductName(String text) {
    if (text.isEmpty) {
      resetSearch();
    } else {
      List<Cart> carts = [];

      this.carts.map((cart) {
        final products = cart.products
            ?.where((product) =>
                (product.title?.toLowerCase().contains(text.toLowerCase()) ??
                    false))
            .toList();

        carts.add(Cart(id: cart.id, products: products));

        carts.removeWhere((element) => element.products?.isEmpty ?? false);

        emit(SearchResultCarts(carts: carts, products: this.products));
      }).toList();
    }
  }

  void resetSearch() {
    emit(CartsLoaded(carts: carts, products: products));
  }
}
