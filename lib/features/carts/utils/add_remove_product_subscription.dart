import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

class AddRemoveProductSubscription {
  AddRemoveProductSubscription._();

  static final _subject = PublishSubject<AddRemoveProductEvent>();

  static void pushUpdate(Product? product,bool isAdded) {
    _subject.add(AddRemoveProductEvent(product,isAdded));
  }

  static Stream<AddRemoveProductEvent> stream() {
    return _subject.stream;
  }
}

class AddRemoveProductEvent extends Equatable {
  final Product? product;
  final bool isAdded;

  const AddRemoveProductEvent(this.product, this.isAdded);

  @override
  List<Object?> get props => [product, isAdded];
}
