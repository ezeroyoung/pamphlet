import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Request<T> {
  Request(this.path,
      {this.data,
      this.queryParameters,
      this.cancelToken,
      this.options,
      this.onSendProgress,
      this.onReceiveProgress});

  Request post<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return Request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: checkOptions('POST', options),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  Request put<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return Request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: checkOptions('PUT', options),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  Request head<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return Request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: checkOptions('HEAD', options),
      cancelToken: cancelToken,
    );
  }

  Request delete<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return Request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: checkOptions('DELETE', options),
      cancelToken: cancelToken,
    );
  }

  Request patch<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return Request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: checkOptions('PATCH', options),
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
    );
  }

  String path;
  Object? data;
  Map<String, dynamic>? queryParameters;
  CancelToken? cancelToken;
  Options? options;
  ProgressCallback? onSendProgress;
  ProgressCallback? onReceiveProgress;

  @protected
  static Options checkOptions(String method, Options? options) {
    options ??= Options();
    options.method = method;
    return options;
  }
}
