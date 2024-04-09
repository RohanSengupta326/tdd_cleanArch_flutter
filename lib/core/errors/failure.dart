import 'package:equatable/equatable.dart';

import 'exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  // a getter just to show statusCode and errorMessage together.
  String get errorMessage => '$statusCode , Message : $message';

  @override
  List<Object> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({
    required super.message,
    required super.statusCode,
  });

  APIFailure.fromException(APIException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
