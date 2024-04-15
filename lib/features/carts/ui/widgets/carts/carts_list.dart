import 'package:carts_task/features/carts/domain/entities/cart_entity.dart';
import 'package:carts_task/features/carts/ui/carts_cubit.dart';
import 'package:carts_task/features/carts/ui/carts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'cart_component.dart';

class CartsList extends StatefulWidget {
  const CartsList({super.key});

  @override
  State<CartsList> createState() => _CartsListState();
}

class _CartsListState extends State<CartsList> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    _refreshController.requestLoading();

    if (context.mounted) {
      context.read<CartsCubit>().getMoreCarts(10).then((value) {
        setState(() {
          _refreshController.loadComplete();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: BlocBuilder<CartsCubit, CartsState>(
        builder: (context, state) {
          if (state is CartsLoaded) {
            return SmartRefresher(
              header: const Text("Loading"),
              enablePullUp: true,
              enablePullDown: false,
              controller: _refreshController,
              onLoading: _onLoading,
              child: _buildCartListView(carts: state.carts),
            );
          } else if (state is SearchResultCarts) {
            if (state.carts.isEmpty) {
              return const Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: 24,horizontal: 8),
                child: Text("There is no items"),
              );
            }
            return _buildCartListView(carts: state.carts,initiallyExpanded: true);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildCartListView({required List<Cart> carts,bool initiallyExpanded = false}) {
    return ListView.builder(
      itemCount: carts.length,
      itemBuilder: (context, index) => CartComponent(
        name: carts[index].id,
        products: carts[index].products,
        initiallyExpanded: initiallyExpanded,
      ),
    );
  }
}
