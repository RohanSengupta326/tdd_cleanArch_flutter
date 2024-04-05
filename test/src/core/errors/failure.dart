// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// we create a general failure class because if failure changes somewhere so that we don't have to change the exact type of failure everywhere .

abstract class Failure extends Equatable {
  final String errorMsg;
  final String errorCode;
  const Failure({
    required this.errorMsg,
    required this.errorCode,
  });

  @override
  List<Object> get props => [errorMsg, errorCode];
}

class ApiFailure extends Failure {
  const ApiFailure({
    required super.errorCode,
    required super.errorMsg,
  });
}
