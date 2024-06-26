import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/service.dart';

part 'start_api_state.dart';

class StartApiCubit extends Cubit<StartApiState> {
  StartApiCubit() : super(StartApiInitial());
  final ApiService apiService = ApiService(Dio());
  void startApi() async{
    await apiService.startModel();
  }
}
