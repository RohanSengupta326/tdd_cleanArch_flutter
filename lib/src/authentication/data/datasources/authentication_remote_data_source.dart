import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    //  1. check to make sure that it returns the right data when the status
    //  code is 200 or the proper response code
    //  2. check to make sure that it "THROWS A CUSTOM EXCEPTION" with the
    //  right message when status code is the bad one
    // TODO: implement getUsers
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> getUsers() {
    // TODO: implement getUsers
    throw UnimplementedError();
  }
}
