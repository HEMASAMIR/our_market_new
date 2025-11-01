
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());
  // final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];

  //STREAM
  void listenToProductsChanges() {
    Supabase.instance.client
        .channel('public:product_table')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'product_table',
          callback: (payload) {
            getProducts(); // تحديث القائمة تلقائيًا بعد أي تعديل في الجدول
          },
        )
        .subscribe();
  }

  // Future<void> getProducts({String? query, String? category}) async {
  //   // products = [];
  //   // searchResults = [];
  //   // categoryProducts = [];
  //   // favoriteProductList = [];
  //   // userOrders = [];
  //   emit(GetDataLoading());
  //   try {
  //     Response response = await _apiServices.getData(
  //         "product_table?select=*,favorites_product(*),purchase_table(*)");
  //     log(response.data.toString());

  //     for (var product in response.data) {
  //       products.add(ProductModel.fromJson(product));
  //     }
  //     // getFavoriteProducts();
  //     // search(query);
  //     // getProductsByCategory(category);
  //     // getUserOrdersProducts();
  //     emit(GetDataSuccess());
  //   } catch (e) {
  //     log(e.toString());
  //     emit(GetDataError());
  //   }
  // }
  Future<void> getProducts() async {
    emit(GetDataLoading());
    try {
      final response =
          await Supabase.instance.client.from('product_table').select();
      products = response.map((e) => ProductModel.fromJson(e)).toList();
      emit(GetDataSuccess());
    } catch (e) {
      emit(GetDataError());
    }
  }

  void search(String? query) {
    if (query != null) {
      for (var product in products) {
        if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
    // }

    // void getProductsByCategory(String? category) {
    //   if (category != null) {
    //     for (var product in products) {
    //       // "sports"
    //       if (product.category!.trim().toLowerCase() ==
    //           category.trim().toLowerCase()) {
    //         categoryProducts.add(product);
    //       }
    //     }
    //   }
    // }

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
  }
}
