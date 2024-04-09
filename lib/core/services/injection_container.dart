import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;

import '../../src/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../src/authentication/data/repositories/authentication_repository_implementation.dart';
import '../../src/authentication/domain/repositories/authentication_repository.dart';
import '../../src/authentication/domain/usecases/create_user.dart';
import '../../src/authentication/domain/usecases/get_users.dart';
import '../../src/authentication/presentation/cubit/authentication_cubit.dart';

// GetIt for dependency injection. Also can use provider.

// instantiating GetIt.
final serviceLocator = GetIt.instance;

// we call this method/injection whenever our application starts. So all the dependencies are loaded at the very beginning.
Future<void> init() async {
  //

  // .. used for accesing the same serviceLocator instance. not calling it multiple times
  serviceLocator
    ..registerFactory(() => AuthenticationCubit(
          // registerFactory is for providing the dependency for the top/starting level which is cubit here.
          // registerlazySingleton is for all the later dependencies lazily, when needed.

          createUser:
              serviceLocator(), // serviceLocator find the wherever the dependency was instantiated.
          getUsers: serviceLocator(),
        ))

    // Use cases domain layer.
    ..registerLazySingleton(() => CreateUser(serviceLocator()))
    ..registerLazySingleton(() => GetUsers(serviceLocator()))

    // Repositories domain layer.

    // whenver anyone is looking for AuthenticationRepository as a dependency, give them an AuthenticationRepositoryImplementation
    // where the actual implementation is cause AuthenticationRepository only is just an abstract class.
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(serviceLocator()))

    // Data Sources data layer
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(serviceLocator()))

    // External Dependencies
    ..registerLazySingleton(http.Client.new); // new = http.Client()

  // HTTP is the final dependency, now this will be provided to AuthRermoteDataSrcImpl => then AuthenticationRepositoryImplementation => ..
  // the serviceLocator of AuthRemoteDataSrcImpl finds the impl of http.Client.new from last line => then AuthenticationRepositoryImplementation's serviceLocator finds the instantiation of AuthRemoteDataSrcImpl.
  // like this , like recursion.
}
