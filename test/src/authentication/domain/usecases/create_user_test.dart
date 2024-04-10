import 'package:clean_arch_tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../repositories/authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  // we create the mock of the dependencies that class requires
  // and the instantitate that class itself by providing the mocked
  // dependencies in setUp.
  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();
  test(
    'should call the [AuthRepo.createUser]',
    () async {
      // Arrange
      // STUB

      // in when we call the insider function with the help of the recieved
      // dependency and expect an answer.
      when(
        () => repository.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));

      //  Act
      // here we call the function in the class inside which we are calling
      // the method using the dependency.
      final result = await usecase(params);

      //  Assert
      // and now we expect it returns the expected result.
      expect(result, equals(const Right<dynamic, void>(null)));

      // and we verify the insider method which should have been
      // called with the dependency is called properly and once.
      // with the actual arguments this time.
      // this time the arguments should be equal to the arguments
      // we used in the act section above.
      verify(
        () => repository.createUser(
            createdAt: params.createdAt,
            name: params.name,
            avatar: params.avatar),
      ).called(1);

      verifyNoMoreInteractions(repository);
    },
  );
}
