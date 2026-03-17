import 'package:equatable/equatable.dart';

/// Centralized Failure class handling all application errors
/// Contains the [statusCode] and [errorMessage] as requested.
abstract class Failure extends Equatable {
  final String errorMessage;
  final int? statusCode;

  const Failure({required this.errorMessage, this.statusCode});

  @override
  List<Object?> get props => [errorMessage, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.errorMessage, super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.errorMessage});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.errorMessage});
}
