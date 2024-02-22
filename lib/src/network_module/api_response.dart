import 'package:flutter/widgets.dart';
import '../app_constants/enums/index.dart';


class ApiResponse<T> {
  ApiResponse();

  NetworkStatus status = NetworkStatus.UNDETERMINED;

  ConnectionState connectionStatus = ConnectionState.none;

  late T data;

  String message = '';

  List errors = [];

  ApiResponse.undertermined() : status = NetworkStatus.UNDETERMINED;

  ApiResponse.loading(this.message) : status = NetworkStatus.LOADING;

  ApiResponse.completed(this.data) : status = NetworkStatus.COMPLETED;

  ApiResponse.error(this.message) : status = NetworkStatus.ERROR;

  ApiResponse.loadingMore(this.message) : status = NetworkStatus.LOADING_MORE;

  ApiResponse.errors(this.errors) : status = NetworkStatus.ERROR;
}