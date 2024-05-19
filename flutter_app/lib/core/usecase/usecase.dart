import 'package:flutter_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccesType, Params> {
  Future<Either<Failure, SuccesType>> call(Params params);
}

class NoParams {}