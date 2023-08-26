import 'dart:io';

class ResponseWithCookies<T> {
  const ResponseWithCookies(
    this.response,
    this.cookies,
  );

  final T response;
  final List<Cookie> cookies;
}
