class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException()
      : super('Unable to connect to the server. Please check your connection.');
}

class TimeoutException extends AppException {
  const TimeoutException()
      : super('The request took too long. Please try again.');
}

class UnauthorizedException extends AppException {
  const UnauthorizedException()
      : super('The request is not authorized. Please check the API key.');
}

class ForbiddenException extends AppException {
  const ForbiddenException()
      : super('You do not have permission to access this resource.');
}

class NotFoundException extends AppException {
  const NotFoundException()
      : super('The requested resource was not found.');
}

class ServerException extends AppException {
  final int statusCode;

  const ServerException(this.statusCode)
      : super('A server error occurred.');
}

class UnexpectedException extends AppException {
  const UnexpectedException()
      : super('An unexpected error occurred.');
}