// we run tests for every class's methods.
// here we run tests for Usecases.

//Test questions :

// What does the class depends on ( constructor values coming from somewhere else)
// answer : AuthenticationRepository
// how can we create a fake version of the dependency
// answer : Use Mocktail package
// how do we control what our dependencies do
// answer :

import 'package:clean_arch_tdd_bloc/src/authentication/domain/repositories/auth_repo.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/usecases/createUser.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late CreateUser usecase;
  late AuthRepo authRepo;

  // for all following tests, it creates different instances of usecase, not just one.
  setUp(
    () {
      authRepo =
          MockAuthRepo(); // creates a mock of the original repo, cause we can't use original one in tests
      usecase = CreateUser(authRepo);
    },
  );

  test(
    'Should call the [AuthRepo.createUser]',
    () async {
      // arrange
      // here figure out in the chain of calling functions which one is the last . here Repo's createUser is the last that will be called. so mock that time when it will be called using Mocktail's when function.
      when(
        () => authRepo.createUser(
          createdAt: any(
              named:
                  'createdAt'), // any only works when its only inbuilt general dart object. (int double string)
          // else we use registerFallbackValue(mention the custom type) above & then any() will find it.
          name: any(named: 'name'),
          avatar: any(
              named:
                  'avatar'), // mentioning the argument name like this because named argument.
        ),
        // thenAnswer works when successful return value after async function.
        // thenReturn works non-async functions.
      ).thenAnswer((invocation) => null);

      final params = const CreateUserParam(
          createdAt: createdAt, name: name, avatar: avatar);

      // Act
      usecase(params);
    },
  );
}
