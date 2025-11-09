import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/components/product_card.dart';
import 'package:our_market/core/cubit/home_cubit.dart';
import 'package:our_market/core/models/product_model/product_model.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key, this.productModel});
  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final cubit = context.read<HomeCubit>();

                // جلب المنتجات المفضلة فقط
                List<ProductModel> favouriteProducts = cubit.products
                    .where((p) => cubit.checkIsFavourite(p.productId!))
                    .toList();

                // لو مفيش منتجات مفضلة
                if (favouriteProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      "You have no favorite products yet!",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                // لو فيه منتجات مفضلة، اعرضها
                return ListView.builder(
                  itemCount: favouriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favouriteProducts[index];
                    return ProductCard(
                      productModel: product,
                      isFavourite: cubit.checkIsFavourite(product.productId!),
                      onPressed: () {
                        bool fav = cubit.checkIsFavourite(product.productId!);
                        if (fav) {
                          cubit.removeFavFromProduct(product.productId!);
                        } else {
                          cubit.addFavToProduct(product.productId!);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
