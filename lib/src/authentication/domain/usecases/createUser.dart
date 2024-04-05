// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_arch_tdd_bloc/src/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:clean_arch_tdd_bloc/src/authentication/domain/repositories/auth_repo.dart';
import 'package:clean_arch_tdd_bloc/src/core/typedefs/typedef.dart';

// EACH USECASE FOLLOW S PRINCIPLES OF SOLID. SINGLE RESPONSIBILITY , SO THAT IF WE NEED TO CHANGE
// THIS CLASS WE WILL DO IT FOR ONE REASON, NOT MULTIPLE CHANGES. THATS WHY MULTIPLE USECASES FOR MULTIPLE METHODS IN REPOSITORY.

class CreateUser implements UsecaseWithParams<void, CreateUserParam> {
  const CreateUser(
    this.authRepo,
  );

  final AuthRepo authRepo;

  // Just to call the createUser function with just the CreateUser() like this, we need to create usecase in the core/usecase folder, and create abstract class then implement it here and override the call method. so now we can call the function without naming it.
  @override
  ResultFuture<void> call(CreateUserParam params) async => authRepo.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParam extends Equatable {
  const CreateUserParam(
      {required this.createdAt, required this.name, required this.avatar});

  // creating an empty model for every Model type class for demo data in case of tests.
  const CreateUserParam.empty()
      : this(
            avatar: 'empty.avatart',
            createdAt: 'emtpy.createdAt',
            name: 'empty.name');

  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object> get props => [createdAt, name, avatar];
}
