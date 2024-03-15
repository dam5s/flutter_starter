import 'package:weather_app/prelude/result.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

import 'async_compute.dart';
import 'http_error.dart';
import 'json_decoder.dart';

enum HttpMethod {
  get,
  post,
  put,
  delete;

  @override
  String toString() => switch (this) {
        get => 'GET',
        post => 'POST',
        put => 'PUT',
        delete => 'DELETE',
      };
}

typedef HttpResult<T> = Result<T, HttpError>;
typedef HttpFuture<T> = Future<HttpResult<T>>;

extension SendRequest on Client {
  HttpFuture<Response> sendRequest(HttpMethod method, Uri url) async {
    try {
      final request = Request(method.toString(), url);
      final streamedResponse = await send(request);
      final response = await Response.fromStream(streamedResponse);

      return Ok(response);
    } on Exception catch (e) {
      return Err(HttpConnectionError(e));
    }
  }
}

extension ResponseHandling on HttpResult<Response> {
  HttpResult<Response> expectStatusCode(int expected) => flatMapOk((response) {
        if (response.statusCode == expected) {
          return Ok(response);
        } else {
          return Err(HttpUnexpectedStatusCodeError(expected, response.statusCode));
        }
      });

  HttpFuture<T> tryParseJson<T>(AsyncCompute async, JsonDecode<T> decode) async {
    return switch (this) {
      Ok(value: final response) => async.compute(
          (response) {
            try {
              final jsonObject = JsonDecoder.fromString(response.body);
              final object = decode(jsonObject);
              return Ok(object);
            } on TypeError catch (e) {
              _logger.e('Failed to parse json: ${response.body}', error: e);
              return Err(HttpDeserializationError(e, response.body));
            }
          },
          response,
        ),
      Err(:final error) => Future.value(Err(error)),
    };
  }
}

final _logger = Logger();
