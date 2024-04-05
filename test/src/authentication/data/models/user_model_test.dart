import 'dart:convert';

import 'package:clean_arch_tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test(
    '[UserModel] should be a subclass of [User] entity',
    () {
      // act  : nothing to call and check result here.

      // assert
      expect(
        tModel,
        isA<Users>(),
      ); // isA meaning, if UserModel extends Users entity.
    },
  );

  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson) as Map<String, dynamic>;

  // grouping tests together. Testing all the functions of UserModel.
  group(
    'fromMap Test',
    () {
      test(
        'Should return a [UserModel] with right data',
        () {
          final result = UserModel.fromMap(tMap);
          expect(
            result,
            equals(
              tModel,
            ),
          );
        },
      );
    },
  );
  group(
    'fromJson Test',
    () {
      test('Should return [UserModel] with right data', () {
        final result = UserModel.fromJson(tJson);
        expect(
          result,
          equals(
            tModel,
          ),
        );
      });
    },
  );

  group(
    'toMap Test',
    () {
      test(
        'Should return [Map<String,dynamic>] with right data',
        () {
          final result = tModel.toMap();
          expect(
            result,
            equals(
              tMap,
            ),
          );
        },
      );
    },
  );

  group(
    'toJson Test',
    () {
      test(
        'Should return Json',
        () {
          final result = tModel.toJson();
          final tJson = json.encode(
            {
              "avatar": "empty.avatar",
              "createdAt": "empty.createdAt",
              "id": "empty.id",
              "name": "empty.name"
            },
          ); // here we are hard coding the json in cause tJson declared before is not working.

          expect(
            result,
            equals(
              tJson,
            ),
          );
        },
      );
    },
  );

  group(
    'copyWith Test',
    () {
      test(
        'Should return a [UserModel] with different data',
        () {
          final result = tModel.copyWith(name: 'Rohan');

          expect(
            result.name,
            equals(
              'Rohan',
            ),
          );
        },
      );
    },
  );
}
