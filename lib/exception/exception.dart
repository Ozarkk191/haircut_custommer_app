/// Custom exception class of the app.
class AppException implements Exception {
  final code;
  final message;
  final prefix;

  AppException([this.code, this.message, this.prefix]);

  // Returns a string representing the exception.
  String toString() {
    return "Error $code : $prefix$message";
  }
}

/// Exception on fetching data from web service.
class FetchDataException extends AppException {
  FetchDataException([int code, String message]) : super(null, message, "Error During Communication: ");
}

/// Exception on receiving 400 Bad Request HTTP status from web service.
class BadRequestException extends AppException {
  BadRequestException([int code, message]) : super(400, message, "Invalid Request: ");
}

/// Exception on receiving 401 Unauthorised or 403 Forbidden HTTP status from web service.
class UnauthorisedException extends AppException {
  UnauthorisedException([int code, message]) : super(401, message, "Unauthorised: ");
}

/// Exception on invalid input.
class InvalidInputException extends AppException {
  InvalidInputException([int code, String message]) : super(400, message, "Invalid Input: ");
}
