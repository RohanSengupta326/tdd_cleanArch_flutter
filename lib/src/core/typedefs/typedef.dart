// typedefs are just Type storing type of long named Types.

import 'package:clean_arch_tdd_bloc/src/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

// using dartz package we can mention one type which return either exception or our desired result.

// will return a Future type of either a failure or a dynamic type of data that we want.
typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultVoid = ResultFuture<void>;
