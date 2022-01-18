class APIExceptions implements Exception {
  final String message;
  final String prefix;
  final String url;

  APIExceptions({required this.message, this.prefix = "", required this.url});
}

class BadRequestException extends APIExceptions {
  BadRequestException({required String message, required String url})
      : super(message: message, prefix: 'Bad Request', url: url);
}

class FetchDataException extends APIExceptions {
  FetchDataException({required String message, required String url})
      : super(message: message, prefix: 'Fetch Data Exception', url: url);
}

class APINotRespondingEXception extends APIExceptions {
  APINotRespondingEXception({required String message, required String url})
      : super(
            message: message, prefix: 'API Not Responding Exception', url: url);
}

class UnAuthorizedException extends APIExceptions {
  UnAuthorizedException({required String message, required String url})
      : super(message: message, prefix: 'UnAuthorized Exception', url: url);
}
