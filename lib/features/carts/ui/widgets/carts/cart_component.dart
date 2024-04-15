import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';
import 'package:carts_task/features/carts/ui/carts_cubit.dart';
import 'package:carts_task/features/core/app_button.dart';
import 'package:carts_task/features/carts/utils/add_remove_product_subscription.dart';
import 'package:carts_task/features/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class CartComponent extends StatefulWidget {
  const CartComponent({
    super.key,
    this.name,
    this.products,
    this.initiallyExpanded = false,
  });

  final String? name;
  final List<Product>? products;
  final bool initiallyExpanded;

  @override
  State<StatefulWidget> createState() => _CartComponentState();
}

class _CartComponentState extends State<CartComponent> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12),
              child: Row(
                children: [
                  Expanded(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: ExpansionTile(
                       maintainState: true,
                        initiallyExpanded: widget.initiallyExpanded,
                        childrenPadding: EdgeInsets.zero,
                        title: Text("Cart ${widget.name}"),
                        children: List.generate(
                            widget.products?.length ?? 0,
                                (index) => ProductItem(
                                  key: ValueKey(widget.products?[index]),
                              product: widget.products?[index],
                            )),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

class ProductItem extends StatefulWidget {
  final Product? product;

  const ProductItem({super.key, this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late Product? product;
  final _composite = CompositeSubscription();

  @override
  void initState() {
    product = widget.product;
    _composite.add(
      AddRemoveProductSubscription.stream().listen((event) {
        if (event.product?.id == product?.id) {
          product = product?.modify(isSelected: event.isAdded);
        }
        setState(() {});
      }),
    );
    super.initState();
  }



  @override
  void dispose() {
    _composite.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 55,
                  width: 55,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    product?.thumbnail ??
                        'https://robohash.org/Terry.png?set=set4',
                    fit: BoxFit.cover,
                    scale: 8.5,
                    errorBuilder: (context, error, stackTrace) {
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Text(
                  product?.title ?? '_',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppButton(
              onTap: () {
                if (!(product?.isSelected ?? false)) {
                  product = product?.modify(isSelected: true);
                  context.read<CartsCubit>().addProduct(product!);
                } else {
                  product = product?.modify(isSelected: false);
                  context.read<CartsCubit>().removeProduct(product);
                }
              },
              name: !(product?.isSelected ?? false) ? "add" : "remove",
              color: !(product?.isSelected ?? false)
                  ? AppColors.secondaryColor
                  : AppColors.thirdColor,
            ),
          )
        ],
      ),
    );
  }
}
