class APIExceptions implements Exception {
  final String message;
  final String prefix;
  final String url;

  APIExceptions([this.message, this.prefix, this.url]);
}

class BadRequestException extends APIExceptions {
  BadRequestException([String message, String url])
      : super(message, 'Bad Request', url);
}
class FetchDataException extends APIExceptions {
  FetchDataException([String message, String url])
      : super(message, 'Fetch Data Exception', url);
}
class APINotRespondingEXception extends APIExceptions {
  APINotRespondingEXception([String message, String url])
      : super(message, 'API Not Responding Exception', url);
}
class UnAuthorizedException extends APIExceptions {
  UnAuthorizedException([String message, String url])
      : super(message, 'UnAuthorized Exception', url);
}
