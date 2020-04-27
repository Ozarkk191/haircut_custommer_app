/// Class representing an encapsulation of data from web service.
class ApiResponse<T> {
  final ResponseStatus status;
  final int httpStatus;
  final String message;
  final T data;

  @override
  String toString() {
    return "Status : $status \n HTTP status : $httpStatus \n Message : $message \n Data : $data";
  }

  /// Creates an instance of the class representing a loading response.
  ApiResponse.loading()
      : status = ResponseStatus.LOADING,
        httpStatus = null,
        message = 'Loading',
        data = null;

  /// Creates a new instance of the class representing a successful response from [data].
  ApiResponse.success(T data)
      : status = ResponseStatus.SUCCESS,
        httpStatus = 200,
        message = 'Success',
        data = data;

  /// Creates an instance of the class representing an error response with [httpStatus] and [message].
  ApiResponse.error(int httpStatus, String message)
      : status = ResponseStatus.ERROR,
        httpStatus = httpStatus,
        message = message,
        data = null;
}

/// Enumeration representing status of a Resource object.
enum ResponseStatus { SUCCESS, LOADING, ERROR }

/// Class representing the error response from Haircut web service.
class ErrorResponse {
  final String name;
  final String message;
  final int code;

  ErrorResponse(this.name, this.message, this.code);

  ErrorResponse.fromJson(Map json)
      : name = json['name'],
        message = json['message'],
        code = json['code'];
}
