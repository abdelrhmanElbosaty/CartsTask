import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';
import 'package:carts_task/features/carts/ui/carts_cubit.dart';
import 'package:carts_task/features/carts/ui/carts_state.dart';
import 'package:carts_task/features/carts/utils/add_remove_product_subscription.dart';
import 'package:carts_task/features/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AddedProducts extends StatefulWidget {
  const AddedProducts({super.key});

  @override
  State<AddedProducts> createState() => _AddedProductsState();
}

class _AddedProductsState extends State<AddedProducts> {
  final _composite = CompositeSubscription();

  @override
  void initState() {
    _composite.add(
      AddRemoveProductSubscription.stream().listen(
        (event) {
          setState(() {});
        },
      ),
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
    return BlocBuilder<CartsCubit, CartsState>(
      builder: (context, state) {
        if ((state is CartsLoaded) && (state.products?.isNotEmpty ?? false)) {
          return _buildItem(state.products);
        } else if ((state is SearchResultCarts) &&
            (state.products?.isNotEmpty ?? false)) {
          return _buildItem(state.products);
        }
        return const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                'Add Products here ...',
              ),
            ));
      },
    );
  }

  Widget _buildItem(List<Product>? products) {
    return SizedBox(
      height: 108,
      child: ListView.builder(
        itemCount: products?.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            _itemBuilder(context, products?[index]),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, Product? product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
              ),
              InkWell(
                  onTap: () {
                    context.read<CartsCubit>().removeProduct(product);
                  },
                  child: CircleAvatar(
                      radius: 10,
                      backgroundColor: AppColors.white,
                      child: Icon(Icons.close, color: AppColors.red, size: 20)))
            ],
          ),
          Text('Price: ${product?.price.toString()}\$')
        ],
      ),
    );
  }
}
