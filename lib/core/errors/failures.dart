import 'package:equatable/equatable.dart';

// lib/core/error/failures.dart
abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class TfliteFailure extends Failure {}
