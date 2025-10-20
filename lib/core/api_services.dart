import 'package:dio/dio.dart';
import 'package:our_market/core/constant/const.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://mqvxvoncvtztchpreghg.supabase.co", 
      headers: {
        "apiKey": SupabaseKeys.anonKey,
      },
    ),
  );

  Future<Response> getData(String path) async {
    return await _dio.get(path);
  }

  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return await _dio.patch(path, data: data);
  }

  Future<Response> deleteData(String path) async {
    return await _dio.delete(path);
  }
}
