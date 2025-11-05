import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_market/core/models/product_model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());
  // final ApiServices _apiServices = ApiServices();
  final String? userId = Supabase.instance.client.auth.currentUser?.id;
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
  Future<void> getProducts(String userId) async {
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
            await getProducts(
              userId ?? '',
            ); // أو أي عملية تحديث مناسبة
          },
        )
        .subscribe();
  }

//Get Fav
  Map<String, bool> favouritesProductes = {}; // يخزن المنتجات المفضلة محليًا

  // إضافة إلى المفضلة
  void addFavToProduct(String productId) async {
    emit(AddToFavoriteLoading());
    try {
      await Supabase.instance.client.from('favourites_table').insert({
        "is_favourite": true,
        "for_user": userId,
        "for_product": productId,
      });

      favouritesProductes[productId] = true; // تحديث محلي
      emit(AddToFavoriteSuccess());
    } catch (e) {
      log('❌ Error adding to favorite: $e');
      emit(AddToFavoriteError());
    }
  }

  // إزالة من المفضلة
  void removeFavFromProduct(String productId) async {
    emit(RemoveFromFavoriteLoading());
    try {
      await Supabase.instance.client
          .from('favourites_table')
          .delete()
          .eq('for_product', productId)
          .eq('for_user', userId ?? '');

      favouritesProductes.remove(productId); // تحديث محلي
      emit(RemoveFromFavoriteSuccess());
    } catch (e) {
      log('❌ Error removing from favorite: $e');
      emit(RemoveFromFavoriteError());
    }
  }

  // للتحقق هل المنتج في المفضلة
  bool checkIsFavourite(String productId) {
    return favouritesProductes.containsKey(productId);
  }
}
/*
 * ist<String> favoriteIds = []; // product id Text
  Future<void> toggleFavorite(String productId, String userId) async {
    try {
      emit(ToggleFavoriteLoading());

      // 👇 1. هل المنتج ده موجود أصلاً في المفضلة؟
      final existing = await Supabase.instance.client
          .from('favourites_table')
          .select()
          .eq('for_product', productId)
          .eq('for_user', userId)
          .maybeSingle();

      if (existing == null) {
        // ✅ مش موجود → نضيفه
        await Supabase.instance.client.from('favourites_table').insert({
          "is_favourite": true,
          "for_user": userId,
          "for_product": productId,
        });

        emit(ToggleFavoriteAdded());
      } else {
        // ❌ موجود → نحذفه
        await Supabase.instance.client
            .from('favourites_table')
            .delete()
            .eq('for_product', productId)
            .eq('for_user', userId);

        emit(ToggleFavoriteRemoved());
      }

      // ✅ بعد العملية، نحدث الحالة العامة
      await getFavorites(userId);
      // emit(ToggleFavoriteAdded());
    } catch (e) {
      log('❌ Error toggling favorite: $e');
      emit(ToggleFavoriteError());
    }
  }

  Future<void> getFavorites(String userId) async {
    try {
      emit(GetFavoritesLoading());
      final response = await Supabase.instance.client
          .from('favourites_table')
          .select('for_product')
          .eq('for_user',
              userId); //مش محتاج تعمل فلترة بـ for_product لأنك أصلاً عايز تجيب كل المنتجات اللي المستخدم حطها في المفضلة.

      favoriteIds = response
          .map<String>((item) => item['for_product'] as String)
          .toList();
      emit(GetFavoritesSuccess());
    } catch (e) {
      emit(GetFavoritesError());
    }
  }

 */
