import 'package:clean_arch_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_arch_tdd_bloc/src/core/errors/exceptions.dart';
import 'package:clean_arch_tdd_bloc/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource authenticationRemoteDataSource;
  late AuthenticationRepositoryImplementation
      authenticationRepositoryImplementation;

  setUp(() {
    authenticationRemoteDataSource = MockAuthRemoteDataSource();
    authenticationRepositoryImplementation =
        AuthenticationRepositoryImplementation(
            authenticationRemoteDataSource: authenticationRemoteDataSource);
  });
  const tException =
      APIException(message: 'Unknown Error occurred', statusCode: 500);
  group(
    'createUser',
    () {
      const createdAt = 'whatever.createdAt';
      const name = 'whatever.name';
      const avatar = 'whatever.avatar';

      test(
        'should call [RemoteDataSource.createUser] and complete successfully when the call to the remote source is successful',
        () {
          when(
            () => authenticationRemoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(
                named: 'avatar',
              ),
            ),
          ).thenAnswer(
            (_) async => Future.value(), // can't write void so Future.value
          );

          final result = authenticationRepositoryImplementation.createUser(
            avatar: avatar,
            createdAt: createdAt,
            name: name,
          );

          expect(
            result,
            equals(
              const Right(
                null,
              ),
            ),
          );

          verify(
            () => authenticationRemoteDataSource.createUser(
              createdAt: createdAt,
              name: name,
              avatar: avatar,
            ),
          ).called(1);
          verifyNoMoreInteractions(authenticationRemoteDataSource);
        },
      );

      test(
        'should return a [ApiFailure] when the call to the remote source is unsuccessful',
        () async {
          //arrange
          when(
            () => authenticationRemoteDataSource.createUser(
              createdAt: any(named: 'cratedAt'),
              name: any(named: 'name'),
              avatar: any(
                named: 'avatar',
              ),
            ),
          ).thenThrow(tException);

          //act
          final result = await authenticationRepositoryImplementation
              .createUser(createdAt: createdAt, name: name, avatar: avatar);

          expect(
            result,
            Left(
              ApiFailure(
                errorMsg: tException.message,
                errorCode: tException.statusCode,
              ),
            ),
          );

          verify(() => authenticationRemoteDataSource.createUser(
              createdAt: createdAt, name: name, avatar: avatar)).called(1);
          verifyNoMoreInteractions(authenticationRemoteDataSource);
        },
      );
    },
  );

  group('getUsers', () {
    test(
      'should call [AuthenticationRemoteDataSource.getUsers] and return a [List<Users>] when call to remote source is successful',
      () async {
        when(() => authenticationRemoteDataSource.getUser()).thenAnswer(
          (_) async => [],
        );

        final result = await authenticationRepositoryImplementation.getUser();

        expect(result, isA<Right<dynamic, List<Users>>>());

        verify(() => authenticationRemoteDataSource.getUser()).called(1);

        verifyNoMoreInteractions(authenticationRemoteDataSource);
      },
    );

    test(
        'should return an [ApiFailure] when the call to the remote source is unsuccessful',
        () async {
      when(() => authenticationRemoteDataSource.getUser())
          .thenThrow(tException);

      final result = await authenticationRemoteDataSource.getUser();

      expect(
          result,
          equals(Left(ApiFailure(
              errorCode: tException.statusCode,
              errorMsg: tException.message))));

      verify(() => authenticationRemoteDataSource.getUser()).called(1);

      verifyNoMoreInteractions(authenticationRemoteDataSource);
    });
  });
}
