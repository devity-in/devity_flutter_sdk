import 'package:devity_sdk/state/devity_screen_event.dart';
import 'package:devity_sdk/state/devity_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevityScreenBloc extends Bloc<DevityScreenEvent, DevityScreenState> {
  DevityScreenBloc() : super(const DevityScreenState()) {
    // Initial empty state
    on<DevityScreenInitialize>(_onInitialize);
    on<DevityScreenUpdateState>(_onUpdateState);
  }

  void _onInitialize(
    DevityScreenInitialize event,
    Emitter<DevityScreenState> emit,
  ) {
    // Initialize state with data, if provided
    emit(DevityScreenState(initialData: event.initialData));
  }

  void _onUpdateState(
    DevityScreenUpdateState event,
    Emitter<DevityScreenState> emit,
  ) {
    // Use the update method in the state to create a new state
    emit(state.update(event.updates));
  }
}
