import 'package:flutter/foundation.dart';

@immutable
sealed class ControllerState<D extends Object> {
  const ControllerState();
}

@immutable
class InitialState<D extends Object> extends ControllerState<D> {
  const InitialState();
}

@immutable
class LoadingState<D extends Object> extends ControllerState<D> {
  const LoadingState();
}

@immutable
class ErrorState<D extends Object> extends ControllerState<D> {
  final Object? errorMessage;

  const ErrorState({required this.errorMessage});
}

@immutable
class SuccessState<D extends Object> extends ControllerState<D> {
  final D data;

  const SuccessState(this.data);
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
}
