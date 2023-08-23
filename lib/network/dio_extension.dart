import 'package:dio/dio.dart';
import 'package:pamphlet/network/request.dart';

extension DioExtension on DioMixin {
  get githubDio => Dio(BaseOptions(baseUrl: 'https://api.github.com'));

  Future<Response<T>> req<T>(Request req) async {
    return request(req.path,
        data: req.data,
        queryParameters: req.queryParameters,
        options: req.options,
        onReceiveProgress: req.onReceiveProgress,
        onSendProgress: req.onSendProgress,
        cancelToken: req.cancelToken);
  }
}
