import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/components/product_card.dart';
import 'package:our_market/core/cubit/home_cubit.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category, // ✅ هنا ضفنا query
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query; // نص البحث
  final String? category;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.watch<HomeCubit>(); // watch عشان يتحدث أوتوماتيكي

        // فلترة المنتجات حسب النص اللي المستخدم كتبه
        List productsToShow = cubit.products;
        if (query != null && query!.isNotEmpty) {
          productsToShow = productsToShow
              .where((p) =>
                  p.productName!.toLowerCase().contains(query!.toLowerCase()))
              .toList();
        }
        // فلترة حسب category
        if (category != null && category!.isNotEmpty) {
          productsToShow = productsToShow
              .where(
                  (p) => p.category!.toLowerCase() == category!.toLowerCase())
              .toList();
        }
        if (state is GetDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetDataError) {
          return const Center(child: Text("Error loading products"));
        } else if (productsToShow.isEmpty) {
          return const Center(child: Text("No products found"));
        } else {
          return ListView.builder(
            shrinkWrap: shrinkWrap ?? true,
            physics: physics ?? const NeverScrollableScrollPhysics(),
            itemCount: productsToShow.length,
            itemBuilder: (context, index) {
              return ProductCard(
                product: productsToShow[index],
              );
            },
          );
        }
      },
    );
  }
}
