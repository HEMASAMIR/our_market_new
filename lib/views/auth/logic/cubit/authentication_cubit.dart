import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:our_market_new_fixed/views/auth/logic/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  SupabaseClient client = Supabase.instance.client;

  Future<void> login({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(LoginLoading());
    try {
      await client.auth.signInWithPassword(password: password, email: email);
      // انتظر 0.5 ثانية عشان Supabase يحدّث حالة المستخدم
      await Future.delayed(const Duration(milliseconds: 500));
      await getUserData();
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginError(e.message));
    } catch (e) {
      log(e.toString());
      emit(LoginError(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      final response = await client.auth.signUp(
        password: password,
        email: email,
      );

      // ✅ انتظر فعلاً لما Supabase يحدّث المستخدم
      final user = response.user;
      if (user == null) {
        await Future.delayed(const Duration(seconds: 1));
      }

      log('✅ Current user after signUp: ${client.auth.currentUser?.id}');

      // ✅ دلوقتي خزّن بيانات المستخدم في الجدول
      await addUserData(name: name, email: email);

      // ✅ وبعدها حدّث الـ userDataModel في الكيوبت
      await getUserData();

      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SignUpError(e.message));
    } catch (e) {
      log(e.toString());
      emit(SignUpError(e.toString()));
    }
  }

  GoogleSignInAccount? googleUser;
  Future<AuthResponse> googleSignIn() async {
    emit(GoogleSignInLoading());
    const webClientId =
        '695947127810-ed6st2u22ov1a33bckft4j172h3ofiau.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
      // clientId: iosClientId,   // ios
      serverClientId: webClientId,
    );
    googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return AuthResponse();
    }
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      emit(GoogleSignInError());
      return AuthResponse();
    }

    AuthResponse response = await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
    // await addUserData(name: googleUser!.displayName!, email: googleUser!.email);
    // await getUserData();

    emit(GoogleSignInSuccess());
    return response;
  }

  Future<void> signOut() async {
    emit(LogoutLoading());
    try {
      await client.auth.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      log(e.toString());
      emit(LogoutError());
    }
  }

  Future<void> resetPassword({required String email}) async {
    emit(PasswordResetLoading());
    try {
      await client.auth.resetPasswordForEmail(email);
      emit(PasswordResetSuccess());
    } catch (e) {
      log(e.toString());
      emit(PasswordResetError());
    }
  }

  // insert  => add only
  // upsert => add or update

  Future<void> addUserData({
    required String name,
    required String email,
  }) async {
    final user = client.auth.currentUser;
    if (user == null) {
      log("❌ No current user found while adding user data");
      return;
    }

    final safeName = name.trim().isEmpty ? 'Unknown User' : name.trim();

    await client.from('users').upsert({
      'user_id': user.id,
      'email': email,
      'name': safeName,
    });

    log("✅ User data inserted successfully -> name: $safeName");
  }

  UserDataModel? userDataModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoading());
    try {
      final user = client.auth.currentUser;
      if (user == null) {
        log("❌ No logged-in user found");
        return;
      }

      final data =
          await client
              .from('users')
              .select()
              .eq("user_id", user.id)
              .maybeSingle();

      if (data == null) {
        log("⚠️ No user data found in Supabase table");
        return;
      }

      userDataModel = UserDataModel(
        email: data["email"],
        name: (data["name"] ?? "").isEmpty ? "Unknown User" : data["name"],
        userId: data["user_id"],
      );

      log("✅ Data fetched: $data");
      log("👤 Loaded user name: ${userDataModel!.name}");

      emit(GetUserDataSuccess());
    } catch (e) {
      log("⚠️ Error in getUserData: $e");
      emit(GetUserDataError());
    }
  }
}
