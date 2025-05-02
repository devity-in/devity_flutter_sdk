import 'package:equatable/equatable.dart';

abstract class DevityScreenEvent extends Equatable {
  const DevityScreenEvent();

  @override
  List<Object?> get props => [];
}

/// Event to initialize the screen state, potentially with initial data.
class DevityScreenInitialize extends DevityScreenEvent {
  final Map<String, dynamic>? initialData;

  const DevityScreenInitialize({this.initialData});

  @override
  List<Object?> get props => [initialData];
}

/// Event to update the screen state (used by SetState action later).
class DevityScreenUpdateState extends DevityScreenEvent {
  final Map<String, dynamic> updates;

  const DevityScreenUpdateState({required this.updates});

  @override
  List<Object?> get props => [updates];
}
