import 'package:clean_arch_tdd_bloc/src/authentication/domain/entities/entity.dart';
import 'package:clean_arch_tdd_bloc/src/core/typedefs/typedef.dart';
import 'package:flutter/material.dart';

abstract class AuthRepo {
  const AuthRepo();

  // to be called from data layer and usecase in domain layer.

  // mentioned in typedef the ResultFuture. returns either an exception or type void.
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar});

  ResultFuture<List<Users>> getUser();
}
