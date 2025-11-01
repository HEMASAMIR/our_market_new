import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/components/product_card.dart';
import 'package:our_market/core/cubit/home_cubit.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.category,
    this.isFavoriteView = false,
    this.isMyOrdersView = false,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;

  final String? category;
  final bool isFavoriteView;
  final bool isMyOrdersView;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        if (state is GetDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetDataError) {
          return const Center(child: Text("Error loading products"));
        } else if (cubit.products.isEmpty) {
          return const Center(child: Text("No products found"));
        } else {
          return ListView.builder(
            shrinkWrap: shrinkWrap ?? true,
            physics: physics ?? const NeverScrollableScrollPhysics(),
            itemCount: cubit.products.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: cubit.products[index],
              );
            },
          );
        }
      },
    );
  }
}
