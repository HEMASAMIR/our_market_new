import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_market_new_fixed/views/product_details/logic/models/rate_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  // final ApiServices _apiServices = ApiServices();
  final supabase = Supabase.instance.client;
  String userId = Supabase.instance.client.auth.currentUser!.id;

  //RATING USING CUBIT

  List<Rate> rates = [];
  int averageRate = 0;
  int userRate = 5;
  void getRate({required String productId}) async {
    emit(GetRateLoading());
    try {
      final response = await supabase
          .from('rates_table')
          .select()
          .eq('for_product', productId);
      rates = response.map((e) => Rate.fromJson(e)).toList();
      // log('response: $response');
      // log('rate length: ${rates.length}');
      _getAverageRate();
      // log('averageRate: ${averageRate.toString()}');
      List<Rate> userRates =
          rates.where((rate) => rate.forUser == userId).toList();
      if (userRates.isNotEmpty) {
        userRate =
            userRates[0].rates ??
            0; // اليوزر بيبقا له اصلا انه يعمل 4 rate واحده فقط بس
      }
      log('user rates length: ${userRates.length}');
      log(
        'rate for user: ${userRates[0].forUser}',
      ); // userId===========  rateForUser
      log('user id: $userId');
      log('userRate: ${userRate.toString()}');
      emit(GetRateSuccess());
    } catch (e) {
      log('❌ Error getting rate: $e.toString()');
      emit(GetRateError());
    }
  }

  void _getAverageRate() {
    averageRate = 0;
    for (var userRate in rates) {
      if (userRate.rates != null) {
        averageRate += userRate.rates!;
      }
    }
    averageRate = averageRate ~/ rates.length;
  }

  // check if user add rate or not
  bool _isUserRateExist({required String productId}) {
    for (var rate in rates) {
      if (rate.forUser == userId && rate.forProduct == productId) {
        return true;
      }
    }
    return false;
  }

  Future<void> addOrUpdateRate({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    emit(AddOrUpdateRateLoading());
    try {
      // ✅ تحقق من وجود تقييم سابق للمستخدم في Supabase

      if (_isUserRateExist(productId: productId)) {
        // ✅ تحديث التقييم الموجود
        await Supabase.instance.client
            .from('rates_table')
            .update(data)
            .eq('for_user', userId)
            .eq('for_product', productId);

        log('✅ Successfully updated existing rate.');
      } else {
        // ✅ إضافة تقييم جديد (insert ماينفعش بعدها eq)
        await Supabase.instance.client.from('rates_table').insert(data);

        log('✅ Successfully added new rate.');
      }

      // ✅ تحديث البيانات فورًا بعد الإضافة أو التعديل
      log('🔄 Calling getRate() to refresh data...');
      getRate(productId: productId);
      log('✅ getRate() completed.');

      emit(AddOrUpdateRateSuccess());
    } catch (e) {
      log('❌ Error in addOrUpdateRate: $e');
      emit(AddOrUpdateRateError());
    }
  }

  //COMMENT (SEND DATA TO DB);
  Future<void> addComment({required Map<String, dynamic> data}) async {
    emit(AddCommentLoading());
    try {
      log("🟢 comment data before insert: $data");
      final res =
          await Supabase.instance.client
              .from('comments_table')
              .insert(data)
              .select(); // بتجيي اخر اضافه;
      log("✅ Comment added successfully: $res");
      emit(AddCommentSuccess());
    } catch (e, st) {
      log("❌ Error adding comment: $e");
      log("🧱 StackTrace: $st");
      emit(AddCommentError());
    }
  }
}
