import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());
  // final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;
  final SupabaseClient client = Supabase.instance.client;

  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];
  List<ProductModel> categoryProducts = [];

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
          await Supabase.instance.client.from('products_table').select();
      products = response.map((e) => ProductModel.fromJson(e)).toList();

      emit(GetDataSuccess());
    } catch (e) {
      emit(GetDataError());
    }
  }

  // void search(String? query) {
  //   if (query != null) {
  //     for (var product in products) {
  //       if (product.productName!.toLowerCase().contains(query.toLowerCase())) {
  //         searchResults.add(product);
  //       }
  //     }
  //   }
  // }
  void search(String query) {
    searchResults.clear(); // لازم نفضيها الأول
    if (query.isNotEmpty) {
      for (var product in products) {
        if (product.productName != null &&
            product.productName!.toLowerCase().contains(query.toLowerCase())) {
          searchResults.add(product);
        }
      }
    }
    emit(GetDataSuccess()); // عشان يحدث الـ UI
  }

  void getProductsByCategory(String? category) {
    emit(GetDataLoading()); // 🌀 نبلغ الواجهة إن فيه تحميل شغال

    try {
      categoryProducts.clear();

      if (category != null && category.isNotEmpty) {
        for (var product in products) {
          if (product.category != null &&
              product.category!.trim().toLowerCase() ==
                  category.trim().toLowerCase()) {
            categoryProducts.add(product);
          }
        }
      }

      emit(GetDataSuccess()); // ✅ نبلغ الواجهة إن البيانات اتحملت
    } catch (e) {
      emit(GetDataError()); // ❌ لو حصل خطأ
    }
  }

  /// ⚡️ الريال تايم - يسمع التغييرات في Supabase
  void listenToProductsChanges() {
    client
        .channel('public:product_table')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'product_table',
          callback: (payload) async {
            print('📡 Real‑time update detected!');
            await getProducts(); // أو أي عملية تحديث مناسبة
          },
        )
        .subscribe();
  }

  Future<void> toggleFavorite(String productId, String userId) async {
    emit(AddToFavoriteLoading());
    try {
      final response = await client
          .from('favorites_product')
          .select()
          .eq('for_user', userId)
          .eq('for_product', productId)
          .maybeSingle();

      if (response != null) {
        // حذف
        await client
            .from('favorites_product')
            .delete()
            .eq('for_user', userId)
            .eq('for_product', productId);
        log("🗑 Product removed from favorites: $productId");
      } else {
        // إضافة
        await client.from('favorites_product').insert({
          'is_favourite': true,
          'for_user': userId,
          'for_product': productId,
        });
        log("❤️ Product added to favorites: $productId");
      }

      emit(AddToFavoriteSuccess());
    } catch (e) {
      log("❌ Error toggling favorite: $e");
      emit(AddToFavoriteError());
    }
  }
}
