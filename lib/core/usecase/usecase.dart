import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  Map<String, dynamic> getBody() => {};

  Map<String, String> getParams() => {};

  @override
  List<Object> get props => [];
}
