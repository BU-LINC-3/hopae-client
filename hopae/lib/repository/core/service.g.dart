// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _CoreService implements CoreService {
  _CoreService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.137.1:8080';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<SessionInfo>> requestSession(
      univerGu, userId, userPw) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'univerGu': univerGu,
      r'userId': userId,
      r'userPw': userPw
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<SessionInfo>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/api/did/issuer/create-session',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SessionInfo.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<String> requestRevoke(credRevId, revRegId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'credRevId': credRevId,
      r'revRegId': revRegId
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/api/did/issuer/revoke-credential',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
