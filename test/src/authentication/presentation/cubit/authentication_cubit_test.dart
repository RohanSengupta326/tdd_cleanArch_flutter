import 'package:clean_arch_tdd_bloc/core/errors/failure.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/usecases/get_users.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/presentation/cubit/authentication_cubit.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tAPIFailure = APIFailure(message: 'message', statusCode: 400);

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(tCreateUserParams); // for using any() inside when().
  });

  // after every test , destroy the current cubit.
  tearDown(() => cubit.close());

  // Initial test for making sure initialState is loaded by default.
  test('initial state should be [AuthenticationInitial', () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  // other state emiting or not, tests.
  group('createUser', () {
    // blocTest package makes testing blocs similar to other widget testing.
    // else it would have been different, listening to streams and then tests. etc.
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [CreatingUser, UserCreated] when successful',
        build: () {
          when(() => createUser(any())).thenAnswer(
            (_) async => const Right(null),
          );
          return cubit; // to carry out the other functionalities of the cubit.
        },
        act: (cubit) => cubit.createUser(
            createdAt: tCreateUserParams.createdAt,
            name: tCreateUserParams.name,
            avatar: tCreateUserParams.avatar),
        // if it was bloc : (bloc) => bloc.add(CreateUserEvent(createdAt: , ...))

        // expecting emitted states.
        expect: () => const [
              CreatingUser(),
              UserCreated(),
            ],
        //

        verify: (_) {
          verify(() => createUser(tCreateUserParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });

    // for Apifailure.
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [CreatingUser, AuthenticationError] when unsuccessful',
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Left(tAPIFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),
      expect: () => {
        const CreatingUser(),
        AuthenticationError(tAPIFailure.errorMessage),
      },
      verify: (_) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  // for getUser methods.
  group('getUsers', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUser, UserLoaded] when successful',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Right([]));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => const [
        GettingUsers(),
        UsersLoaded([]),
      ],
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'should emit [GettingUser, AuthenticationError] when unsuccessful',
      build: () {
        when(() => getUsers()).thenAnswer((_) async => const Left(tAPIFailure));
        return cubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => {
        const GettingUsers(),
        AuthenticationError(tAPIFailure.errorMessage),
      },
      verify: (_) {
        verify(() => getUsers()).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
