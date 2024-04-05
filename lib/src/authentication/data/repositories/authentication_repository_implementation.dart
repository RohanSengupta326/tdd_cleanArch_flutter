// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/repositories/auth_repo.dart';
import 'package:clean_arch_tdd_bloc/src/core/errors/exceptions.dart';
import 'package:clean_arch_tdd_bloc/src/core/errors/failure.dart';
import 'package:clean_arch_tdd_bloc/src/core/typedefs/typedef.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImplementation implements AuthRepo {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  AuthenticationRepositoryImplementation({
    required this.authenticationRemoteDataSource,
  });

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    // write tests before you implement this functions.
    // then when test fails , then write the implementation as much as needed just to pass the test.

    try {
      await authenticationRemoteDataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return Right(null);
    } on APIException catch (e) {
      return Left(
        ApiFailure(
          errorMsg: e.message,
          errorCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<List<Users>> getUser() async {
    try {
      final result = await authenticationRemoteDataSource.getUser();
      return Right(result);
    } on APIException catch (e) {
      return Left(ApiFailure(errorCode: e.statusCode, errorMsg: e.message));
    }
  }
}
