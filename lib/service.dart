import 'package:dio/dio.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:5000/";
  final Dio dio;
  ApiService(this.dio);
  Future<void> startModel()async {
    await dio.get(baseUrl);
  }
}
