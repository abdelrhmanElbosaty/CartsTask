import 'package:carts_task/features/carts/ui/carts_cubit.dart';
import 'package:carts_task/features/carts/ui/widgets/added_products/added_products.dart';
import 'package:carts_task/features/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'carts_state.dart';
import 'widgets/carts/carts_list.dart';
import 'widgets/search_text_field.dart';

class CartsPage extends StatelessWidget {
  const CartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => CartsCubit()..onCubitStart(),
          child: const _CartsPage(),
        ),
      ),
    );
  }
}

class _CartsPage extends StatelessWidget {
  const _CartsPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<CartsCubit, CartsState>(
          builder: (context, state) {
            if (state is CartsLoading) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: AppColors.indicatorColor,
                ),
              );
            } else if (state is CartsError) {
              return Center(
                child: Text(state.message.toString()),
              );
            } else {
              return Column(
                children: [
                  const AddedProducts(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: SearchTextField(),
                  ),
                  const CartsList(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
