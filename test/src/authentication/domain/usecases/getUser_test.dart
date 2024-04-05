import 'package:clean_arch_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/repositories/auth_repo.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/usecases/createUser.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/usecases/getUser.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

void main() {
  late GetUsers usecase;
  late AuthRepo authRepo;

  setUp(
    () {
      authRepo = MockAuthRepo();
      usecase = GetUsers(authRepo);
    },
  );

  final tResponse = [Users.empty()];
  test(
    'Should call the [AuthRepo.getUsers]',
    () async {
      // arrange

      when(
        () => authRepo.getUser(),
      ).thenAnswer(
        (_) async => Right(tResponse),
      );

      // Act
      final result = await usecase();

      // Assert
      expect(
        result,
        equals(
          Right<dynamic, List<Users>>(tResponse),
        ),
      );
      verify(
        () => authRepo.getUser(),
      ).called(
        1,
      );

      verifyNoMoreInteractions(authRepo);
    },
  );
}
