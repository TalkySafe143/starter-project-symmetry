import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? error;
  final String? errorMessage;

  const DataState({this.data, this.error, this.errorMessage});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataDioFailed<T> extends DataState<T> {
  const DataDioFailed(DioException error) : super(error: error);
}

class DataGenericFailed<T> extends DataState<T> {
  const DataGenericFailed(String errorMessage)
      : super(errorMessage: errorMessage);
}
