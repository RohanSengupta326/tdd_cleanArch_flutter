import 'dart:io';

// just to get the json as string form user.json to userModel_test.dart.
String fixture(String fileName) =>
    File('test/fixtures/$fileName').readAsStringSync();
