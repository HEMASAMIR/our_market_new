import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:our_market/core/components/custom_circle_pro_ind.dart';
import 'package:our_market/core/components/product_card.dart';
import 'package:our_market/core/cubit/home_cubit.dart';
import 'package:our_market/core/functions/show_msg.dart';
import 'package:our_market/core/models/product_model/product_model.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    super.key,
    this.shrinkWrap,
    this.physics,
    this.query,
    this.category,
    this.isFavoriteView = false,
    this.isMyOrdersView = false,
  });

  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final String? query;
  final String? category;
  final bool isFavoriteView;
  final bool isMyOrdersView;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // if (state is BuyProductDone) {
        //   showMsg(context, "Payment Success , check your orders");
        // }
      },
      builder: (context, state) {
        HomeCubit homeCubit = context.read<HomeCubit>();
        // List<ProductModel> products = query != null
        //     ? context.read<HomeCubit>().searchResults
        //     :
        //     // query == null
        //     category != null
        //         ? context.read<HomeCubit>().categoryProducts
        //         : isFavoriteView
        //             ? homeCubit.favoriteProductList
        //             : isMyOrdersView
        //                 ? homeCubit.userOrders
        //                 :
        //                 // query == null & category == null
        //                 context.read<HomeCubit>().products;
        return ListView.builder(
            shrinkWrap: shrinkWrap ?? true,
            physics: physics ?? const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return TextButton(onPressed: () {}, child: const Text("hello"));
            });
      },
    );
  }
}
