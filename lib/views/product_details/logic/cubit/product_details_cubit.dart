import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_market/views/product_details/logic/models/rate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  // final ApiServices _apiServices = ApiServices();
  final supabase = Supabase.instance.client;
  String userId = Supabase.instance.client.auth.currentUser!.id;

  List<Rate> rates = []; // rate.forUser == user id
  //rate ==> int
  // for_user ==> String (user id)
  int averageRate = 0;
  int userRate = 5;

  Future<void> getRates({required String productId}) async {
    emit(GetRateLoading());
    try {
      // Supabase client

      // نجيب البيانات من جدول rates_table
      //الطجريقه دي افضل من التانيه عشان co دي
      final response = await supabase
          .from('rates_table')
          .select()
          .eq('for_product', productId);

      // نحولها لنموذج Rate
      rates = response.map((e) => Rate.fromJson(e)).toList();
      if (rates.isNotEmpty) {
        _getAverageRate();
        _getUserRate();
        log('averageRate: $averageRate');
      }

      emit(GetRateSuccess());
    } catch (e) {
      log('Error fetching rates: $e');
      emit(GetRateError()); // خليه Error عشان تبقى واضحه
    }
  }

  void _getUserRate() {
    List<Rate> userRates = rates.where((Rate rate) {
      return rate.forUser == userId;
    }).toList();
    if (userRates.isNotEmpty) {
      userRate = userRates[0].rate!; // user rate هو بيعمل rate واحد فقط
    }
    log('user rates length: $userRates.length'); //وده طبيعي لو كل مستخدم يقدر يقيّم المنتج مرة واحدة فقط. //immer 1 weil er erster user im Application بيطبع عدد التقييمات (Rates) اللي تخص المستخدم ده من الجدول.
    log('userRate: $userRate'); // sum / avg بيطبع قيمة التقييم اللي المستخدم عملها — مثلاً 4 أو 5.
    log('rate for user : ${userRates[0].forUser}'); //user  // userRate == rate for user; بيطبع ID المستخدم اللي عمل التقييم، اللي جاي من الـ database.
    log('user id: $userId'); //Id بيطبع الـ ID الخاص بالمستخدم الحالي اللي عامل تسجيل دخول دلوقتي في التطبيق.
  }

  void _getAverageRate() {
    log('rates length: ${rates.length}');

    // عملت كدا بعد ما مليتها فوق لانها سيتم تحديثها في الفنكشن اللي بعدها
    for (var userRate in rates) {
      log(userRate.rate.toString());
      if (userRate.rate != null) {
        //[4,2,1,5,3]
        averageRate += userRate.rate!; //15
      }
    }
    if (rates.isNotEmpty) {
      averageRate = averageRate ~/ rates.length; // averageRate = 3
    }
  }

// ✅ Check if user's rate exists for product
  // Future<bool> _isUserRateExist({required String productId}) async {
  //   try {
  //     final response = await supabase
  //         .from('rates_table')
  //         .select('id')
  //         .eq('for_user', userId)
  //         .eq('for_product', productId)
  //         .maybeSingle(); // بيرجع صف واحد أو null
  //     return response != null;
  //   } catch (e) {
  //     log('Error checking rate: $e');
  //     return false;
  //   }
  // }

  // ✅ Add or update user's rate
  // Future<void> addOrUpdateUserRate({
  //   required String productId,
  //   required Map<String, dynamic> data,
  // }) async {
  //   emit(AddOrUpdateRateLoading());
  //   try {
  //     final exists = await _isUserRateExist(productId: productId);

  //     if (exists) {
  //       // لو فيه تقييم موجود → نحدثه
  //       await supabase
  //           .from('rates_table')
  //           .update(data)
  //           .eq('for_user', userId)
  //           .eq('for_product', productId);

  //       log('✅ Rate updated successfully');
  //     } else {
  //       // لو مفيش تقييم → نضيفه
  //       await supabase.from('rates_table').insert({
  //         ...data,
  //         'for_user': userId,
  //         'for_product': productId,
  //       });

  //       log('✅ Rate added successfully');
  //     }

  //     emit(AddOrUpdateRateSuccess());
  //   } catch (e, st) {
  //     log('❌ Error in addOrUpdateUserRate: $e');
  //     log(st.toString());
  //     emit(AddOrUpdateRateError());
  //   }
  // }
  Future<void> addOrUpdateUserRate({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    emit(AddOrUpdateRateLoading());
    try {
      // 🔹 تحقق من وجود تقييم للمستخدم في Supabase نفسه
      final response = await Supabase.instance.client
          .from('rates_table')
          .select()
          .eq('for_user',
              userId) //FILTER IF HIS ONLY TMAM hat3mel update in all user
          .eq('for_product',
              productId); // لما اعملهم فلتر ع الاتنين تمام احسن عشان ميعملش لكله هيعمل فقط لليوزر دا والمنتج دا فقط

      if (response.isNotEmpty) {
        // ✅ التقييم موجود ⇒ نعمل update
        log('🟡 User rate already exists — updating it...');

        await Supabase.instance.client
            .from('rates_table')
            .update(data)
            .eq('for_user', userId)
            .eq('for_product', productId);
        log('✅ Successfully updated existing rate.');
      } else {
        // ❌ مش موجود ⇒ أضف تقييم جديد
        log('🟢 No user rate found — adding new one...');
        await Supabase.instance.client.from('rates_table').insert(data);
        log('✅ Successfully added new rate.');
      }

      // 🌀 بعد الإضافة أو التحديث، رجّع أحدث البيانات
      // 🌀 بعد التعديل أو الإضافة، نرجّع أحدث بيانات الـ rates
      log('🔄 Calling getRates() to refresh data...');
      await getRates(
          productId:
              productId); // عشان تتحدث ف فحه نفسها علطول اشطاا مش لازم يعني اخرج وادخل عشان تتحدث
      log('✅ getRates() completed.');

      emit(AddOrUpdateRateSuccess());
    } catch (e) {
      log('❌ ERROR in addOrUpdateUserRate: $e');
      log('🧱 STACK TRACE:\n$e');
      emit(AddOrUpdateRateError());
    }
  }

//COMMENT (SEND DATA TO DB);
  Future<void> addComment({required Map<String, dynamic> data}) async {
    emit(AddCommentLoading());
    try {
      log("🟢 comment data before insert: $data");
      final res =
          await Supabase.instance.client.from('comments_table').insert(data);
      log("✅ Comment added successfully: $res");
      emit(AddCommentSuccess());
    } catch (e, st) {
      log("❌ Error adding comment: $e");
      log("🧱 StackTrace: $st");
      emit(AddCommentError());
    }
  }
}
/**
 * void getReates(required String productId){
 * Response res = Supabase.instance.client.from('rates_table').select().eq('for_product', productId);
 * rates=  res.map((e) => Rate.fromJson(e)).toList();
 * //avg
 * for(userRate in rates){
 *   if(userRate.rate != null){
 *     averageRate += userRate.rate!;
 *   }
 * }
 * if(rates.isNotEmpty){
 *   averageRate = averageRate ~/ rates.length;
 * }
 * }
 */
