import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CartsState extends Equatable {
  const CartsState();

  @override
  List<Object?> get props => [];
}

class CartsInitial extends CartsState {}

class CartsLoading extends CartsState {}

class CartsLoaded extends CartsState {
  final List<Cart> carts;
  final List<Product>? products;

  const CartsLoaded({required this.carts, this.products});

  @override
  List<Object?> get props => [carts, products];
}

class CartsError extends CartsState {
  final String message;

  const CartsError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchResultCarts extends CartsState {
  final List<Cart> carts;
  final List<Product>? products;

  const SearchResultCarts({required this.carts, this.products});

  @override
  List<Object?> get props => [carts, products];
}
