part of 'start_api_cubit.dart';

@immutable
sealed class StartApiState {}

final class StartApiInitial extends StartApiState {}

final class StartApiSuccess extends StartApiState {}

final class StartApiFailure extends StartApiState {
  final String errMessage;
  StartApiFailure({required this.errMessage});
}
