import 'package:clean_arch_tdd_bloc/core/errors/exceptions.dart';
import 'package:clean_arch_tdd_bloc/core/errors/failure.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  final tException = APIException(
    message: 'Unknown Error Occured',
    statusCode: 500,
  );

  group('createUser', () {
    const createdAt = 'whatever.createdAt';
    const name = 'whatever.name';
    const avatar = 'whatever.avatar';
    test(
      'should call the [RemoteDataSource.createUser] and complete '
      'successfully when the call of the remote source is successful',
      () async {
        //  arrange
        when(
          () => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')),
        ).thenAnswer((_) async => Future
            .value()); // normally returns void but we can't write void so we write Future.value();

        //  act
        final result = await repoImpl.createUser(
            createdAt: createdAt, name: name, avatar: avatar);

        //  assert
        expect(result, equals(const Right(null)));

        verify(() => remoteDataSource.createUser(
              createdAt: createdAt,
              name: name,
              avatar: avatar,
            )).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [APIFailure] when the call to the remote '
      'source is unsuccessful',
      () async {
        //  Arrange
        when(
          () => remoteDataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(
                named: 'avatar',
              )),
        ).thenThrow(
          tException,
        );

        final result = await repoImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        expect(
          result,
          equals(
            Left(
              APIFailure.fromException(
                tException,
              ),
            ),
          ),
        );
        verify(() => remoteDataSource.createUser(
            createdAt: createdAt, name: name, avatar: avatar)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('getUser', () {
    test(
      'should call the [RemoteDataSource.getUser] and return [List<User>]'
      ' when call to remote source is successful',
      () async {
        //  arrange
        when(() => remoteDataSource.getUsers()).thenAnswer(
          (_) async => [],
        );

        final result = await repoImpl.getUsers();

        expect(result, isA<Right<dynamic, List<User>>>());
        // in dart we can not equate empty Map with result like :  expect(result, List<User>[]); hence we have use 'isA()'
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [APIFailure] when the call to the remote '
      'source is unsuccessful',
      () async {
        //  arrange
        when(() => remoteDataSource.getUsers()).thenThrow(tException);

        final result = await repoImpl.getUsers();

        expect(result, equals(Left(APIFailure.fromException(tException))));
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
