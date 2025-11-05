import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/components/products_list.dart';
import 'package:our_market/core/cubit/home_cubit.dart';
import 'package:our_market/core/models/product_model/product_model.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key, this.productModel});
  final ProductModel? productModel;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = context.watch<HomeCubit>();

        // ✅ لو المنتجات مش جاهزة
        if (cubit.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const Center(
                child: Text(
                  "Your Favorite Products ❤️",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ProductsList(),
            ],
          ),
        );
      },
    );
  }
}
