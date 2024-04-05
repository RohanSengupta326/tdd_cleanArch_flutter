import 'package:clean_arch_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:clean_arch_tdd_bloc/src/authentication/domain/repositories/auth_repo.dart';
import 'package:clean_arch_tdd_bloc/src/core/typedefs/typedef.dart';
import 'package:clean_arch_tdd_bloc/src/core/usecase/usecase.dart';

class GetUsers implements UsecaseWithoutParams<List<Users>> {
  const GetUsers(
    this.authRepo,
  );

  final AuthRepo authRepo;

  @override
  ResultFuture<List<Users>> call() async => authRepo.getUser();
}
