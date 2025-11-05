import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:our_market/views/product_details/logic/models/rate_model.dart';
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
        userRate = userRates[0].rates ??
            0; // اليوزر بيبقا له اصلا انه يعمل 4 rate واحده فقط بس
      }
      log('user rates length: ${userRates.length}');
      log('rate for user: ${userRates[0].forUser}'); // userId===========  rateForUser
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
      final res = await Supabase.instance.client
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

// Future<void> addOrUpdateRate({
//     required String productId,
//     required Map<String, dynamic> data,
//   }) async {
//     emit(AddOrUpdateRateLoading());
//     try {
//       // ✅ نتحقق هل المستخدم قيم المنتج بالفعل ولا لأ
//       if (_isUserRateExist(productId: productId)) {
//         await Supabase.instance.client
//             .from('rates_table')
//             .update(data)
//             .eq('for_user', userId)
//             .eq('for_product', productId);

//         log('✅ Successfully updated existing rate.');
//       }
//       // ✅ تحديث التقييم الموجود
//       else {
//         // ✅ إضافة تقييم جديد (ملهاش eq هنا)
//         await Supabase.instance.client.from('rates_table').insert(data);

//         log('✅ Successfully added new rate.');
//       }
//       // ✅ استدعاء getRate لتحديث الصفحة فورًا
//       log('🔄 Calling getRate() to refresh data...');
//       await getRate(productId: productId);
//       log('✅ getRate() completed.');

//       emit(AddOrUpdateRateSuccess());
//     } catch (e) {
//       log('❌ Error in addOrUpdateRate: $e');
//       emit(AddOrUpdateRateError());
//     }
//   }

/**
 * List<Rate> rates = []; // rate.forUser == user id
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
    }*/
