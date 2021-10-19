// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _AriesService implements AriesService {
  _AriesService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://192.168.137.1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String> requestCreateInvitation(body, port, alias, autoAccept) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'alias': alias,
      r'auto_accept': autoAccept
    };
    final _headers = <String, dynamic>{
      r'Content-Type': 'application/json;charset=utf-8'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = body;
    final _result = await _dio.fetch<String>(_setStreamType<String>(Options(
            method: 'POST',
            headers: _headers,
            extra: _extra,
            contentType: 'application/json;charset=utf-8')
        .compose(_dio.options, ':$port/connections/create-invitation',
            queryParameters: queryParameters, data: _data)
        .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<String> requestCredentials(port) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, ':$port/credentials',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<Wallet> requestWallet(port) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Wallet>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, ':$port/wallet/did',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Wallet.fromJson(_result.data!);
    return value;
  }

  @override
  Future<String> requestConnections(port, alias, state) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'alias': alias, r'state': state};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, ':$port/connections',
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
