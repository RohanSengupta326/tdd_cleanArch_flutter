import 'dart:convert';

import 'package:clean_arch_tdd_bloc/core/errors/exceptions.dart';
import 'package:clean_arch_tdd_bloc/core/utils/constants.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(
        Uri()); // cause we are sending [Uri()] as [any()] in [when()] function. so Uri is not default datatype we have to mention it using [registerFallbackValue()].
  });

  group('createUser', () {
    test(
      'should complete successfully when the status code is 200 or 201',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('User created successfully', 201),
        );

        final methodCall = remoteDataSource.createUser;
        // we are not declaring the arguments of the function here because this func returns void type but inside expect we can't expect void type return so thats why different type of calling the func here insdie expect.

        expect(
            // here we don't need to wrap the method in higher order function call we are just checking if the method completes but not checking any thrown error.
            // but in case of exceptions we wrap it in higher order function to call it and expect some thrown error
            methodCall(
              createdAt: 'createdAt',
              name: 'name',
              avatar: 'avatar',
            ),
            completes); // 'completes' we can use instead of Future.value() as we are expecting void here.

        verify(
          // in verify we check if the method was called with the exact correct URL that we want.
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      'should throw [APIException] when the status code is not 200 or '
      '201',
      () async {
        when(() => client.post(any(), body: any(named: 'body'))).thenAnswer(
          (_) async => http.Response('Invalid email address', 400),
        );
        final methodCall = remoteDataSource.createUser;

        expect(
            // here in case of exception we are using () async because we want the higher function to call that method and check if it throws an error.
            () async => methodCall(
                  createdAt: 'createdAt',
                  name: 'name',
                  avatar: 'avatar',
                ),
            throwsA(const APIException(
                message: 'Invalid email address', statusCode: 400)));

        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndpoint),
            body: jsonEncode({
              'createdAt': 'createdAt',
              'name': 'name',
              'avatar': 'avatar',
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  // Tests for getUser
  group('getUser', () {
    const tUsers = [UserModel.empty()];
    test(
      'should return [List<User>] when the status code is 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
        );

        final result = await remoteDataSource.getUsers();

        expect(result, equals(tUsers));

        verify(() => client.get(Uri.https(kBaseUrl, kGetUserEndpoint)))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );
    test(
      'should throw [APIException] when the status code is not 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response('Invalid email address', 500),
        );

        final methodCall = remoteDataSource.getUsers;

        expect(
          () async => methodCall(),
          throwsA(const APIException(
              message: 'Invalid email address', statusCode: 500)),
        );

        verify(() => client.get(Uri.https(kBaseUrl, kGetUserEndpoint)))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
