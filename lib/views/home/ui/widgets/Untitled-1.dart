// Map<String, bool> favoriteProducts = {};
  // "product_id" : true
  // add To Favorite
  // Future<void> addToFavorite(String productId) async {
  //   emit(AddToFavoriteLoading());
  //   try {
  //     await _apiServices.postData("favorite_products", {
  //       "is_favorite": true,
  //       "for_user": userId,
  //       "for_product": productId,
  //     });

  //     await getProducts();
  //     favoriteProducts.addAll({
  //       productId: true,
  //     });

  //     emit(AddToFavoriteSuccess());
  //   } catch (e) {
  //     log(e.toString());
  //     emit(AddToFavoriteError());
  //   }
  // }

  // bool checkIsFavorite(String productId) {
  //   return favoriteProducts.containsKey(productId);
  // }
  // // remove from favorite

//   Future<void> removeFavorite(String productId) async {
//     emit(RemoveFromFavoriteLoading());
//     try {
//       await _apiServices.deleteData(
//           "favorite_products?for_user=eq.$userId&for_product=eq.$productId");
//       await getProducts();
//       favoriteProducts.removeWhere((key, value) => key == productId);
//       emit(RemoveFromFavoriteSuccess());
//     } catch (e) {
//       log(e.toString());
//       emit(RemoveFromFavoriteError());
//     }
//   }

//   // get favorite products
//   List<ProductModel> favoriteProductList = [];
//   void getFavoriteProducts() {
//     for (ProductModel product in products) {
//       if (product.favoriteProducts != null &&
//           product.favoriteProducts!.isNotEmpty) {
//         for (FavoriteProduct favoriteProduct in product.favoriteProducts!) {
//           if (favoriteProduct.forUser == userId) {
//             favoriteProductList.add(product);
//             favoriteProducts.addAll({product.productId!: true});
//           }
//         }
//       }
//     }
//   }

//   Future<void> buyProduct({required String productId}) async {
//     emit(BuyProductLoading());
//     try {
//       await _apiServices.postData("purchase_table", {
//         "for_user": userId,
//         "is_bought": true,
//         "for_product": productId,
//       });
//       emit(BuyProductDone());
//     } catch (e) {
//       log(e.toString());
//       emit(BuyProductError());
//     }
//   }

//   // get favorite products
//   List<ProductModel> userOrders = [];
//   void getUserOrdersProducts() {
//     for (ProductModel product in products) {
//       if (product.purchaseTable != null && product.purchaseTable!.isNotEmpty) {
//         for (PurchaseTable userOrder in product.purchaseTable!) {
//           if (userOrder.forUser == userId) {
//             userOrders.add(product);
//           }
//         }
//       }
//     }
//   }
// }
/**  List<ProductModel> searchResults = [];
  List<ProductModel> categoryProducts = []; */
