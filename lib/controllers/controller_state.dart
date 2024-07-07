import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ControllerState<D extends Object> extends Equatable {
  const ControllerState();
}

@immutable
class InitialState<D extends Object> extends ControllerState<D> {
  const InitialState();

  @override
  List<Object?> get props => [];
}

@immutable
class LoadingState<D extends Object> extends ControllerState<D> {
  const LoadingState();

  @override
  List<Object?> get props => [];
}

@immutable
class ErrorState<D extends Object> extends ControllerState<D> {
  final Object? errorMessage;
  final bool offline;
  const ErrorState({required this.errorMessage, this.offline = false});

  @override
  List<Object?> get props => [errorMessage, offline];
}

@immutable
class SuccessState<D extends Object> extends ControllerState<D> {
  final D data;

  const SuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

@immutable
class CachedState<D extends Object> extends ControllerState<D> {
  final D data;
  final bool offline;
  final DateTime lastUpdated;

  const CachedState(
    this.data, {
    required this.offline,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [data, offline, lastUpdated];
}
