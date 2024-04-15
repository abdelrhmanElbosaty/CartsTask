import 'package:carts_task/features/carts/ui/carts_cubit.dart';
import 'package:carts_task/features/carts/ui/carts_state.dart';
import 'package:carts_task/features/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller = TextEditingController();

  SearchTextField({super.key});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    return BlocBuilder<CartsCubit, CartsState>(
      builder: (context, state) => TextFormField(
              onTap: () {},
              onChanged: context.read<CartsCubit>().searchByProductName,
              controller: controller,
              cursorColor: AppColors.forthColor,
              cursorHeight: 25,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  fillColor: AppColors.fifthColor,
                  hintText: "Search",
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        context.read<CartsCubit>().resetSearch();
                        currentFocus.unfocus();
                        controller.clear();
                      },
                      icon: const Icon(Icons.close)),
                  prefixIcon: IconButton(
                      onPressed: () {
                        context
                            .read<CartsCubit>()
                            .searchByProductName(controller.text);
                        currentFocus.unfocus();
                      },
                      icon: const Icon(Icons.search))),
            ),
    );
  }
}
