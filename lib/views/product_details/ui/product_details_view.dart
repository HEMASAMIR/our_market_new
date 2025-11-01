import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:our_market/core/components/cache_image.dart';
import 'package:our_market/core/components/custom_circle_pro_ind.dart';
import 'package:our_market/core/functions/build_appbar.dart';
import 'package:our_market/core/functions/navigate_without_back.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:our_market/views/auth/logic/cubit/authentication_cubit.dart';
import 'package:our_market/views/product_details/logic/cubit/product_details_cubit.dart';
import 'package:our_market/views/product_details/ui/widgets/comments_list.dart';

import '../../auth/ui/widgets/custom_text_field.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getRates(productId: widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) async {
          // FOR UPDATE DATE IN SAME PAGE
          if (state is AddOrUpdateRateSuccess) {
            navigateWithoutBack(context, widget);
          }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();
          return Scaffold(
            appBar: buildCustomAppBar(
                context, widget.product.productName ?? "Product Name"),
            body: state is GetRateLoading || state is AddCommentLoading
                ? const CustomCircleProgIndicator()
                : ListView(
                    children: [
                      CaheImage(
                        url: widget.product.imageUrl ??
                            "https://img.freepik.com/premium-psd/kitchen-product-podium-display-background_1101917-13418.jpg?w=900",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.product.productName ??
                                    "Product Name"),
                                Text(widget.product.price != null
                                    ? "${widget.product.price} LE"
                                    : "... LE"),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("${cubit.averageRate} "),
                                    const Icon(Icons.star, color: Colors.amber),
                                  ],
                                ),
                                const Icon(Icons.favorite, color: Colors.grey),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(widget.product.description ??
                                "Product Description"),
                            const SizedBox(
                              height: 20,
                            ),
                            RatingBar.builder(
                              initialRating: cubit.userRate.toDouble(),
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                cubit.addOrUpdateUserRate(
                                  productId: widget.product.productId!,
                                  data: {
                                    "rate": rating.toInt(),
                                    "for_user": cubit.userId, // exist in cubit
                                    "for_product": widget
                                        .product.productId // product in Model
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            CustomTextFormField(
                              controller: _commentController,
                              labelText: "Type your feedback",
                              suffIcon: IconButton(
                                onPressed: () async {
                                  final authCubit =
                                      context.read<AuthenticationCubit>();
                                  final commentCubit =
                                      context.read<ProductDetailsCubit>();

                                  // 🟢 اطبع قبل التحميل عشان نتابع
                                  log("🕓 Fetching user data...");

                                  await authCubit.getUserData();
                                  // استنى فعلاً لحد ما البيانات تيجي

                                  // 🟢 اتأكد ان فيه بيانات
                                  if (authCubit.userDataModel == null) {
                                    log("❌ userDataModel is NULL after getUserData");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("User data not loaded")),
                                    );
                                    return;
                                  }

                                  log("👤 userData before comment: ${authCubit.userDataModel!.name.toString()}"); // لو عندك toJson()
                                  // log("👤 user name before comment: ${userData?.name}");

                                  await commentCubit.addComment(
                                    data: {
                                      "comment": _commentController.text.trim(),
                                      "for_user":
                                          authCubit.userDataModel!.userId,
                                      "for_product": widget.product.productId,
                                      "user_name":
                                          authCubit.userDataModel!.name,
                                    },
                                  );

                                  _commentController.clear();
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Row(
                              children: [
                                Text(
                                  "Comments",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CommentsList(
                              productModel: widget.product,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
