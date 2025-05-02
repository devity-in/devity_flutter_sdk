import 'package:devity_sdk/core/core.dart';
import 'package:devity_sdk/core/models/set_state_action_model.dart';
import 'package:devity_sdk/state/devity_screen_bloc.dart';
import 'package:devity_sdk/state/devity_screen_event.dart';
import 'package:flutter/widgets.dart'; // Need BuildContext
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Consider making this injectable or accessed via context
class ActionHandler {
  /// Executes a list of actions identified by their IDs.
  ///
  /// Requires the current [BuildContext] to access the [DevityScreenBloc]
  /// and the fully parsed [SpecModel] to look up action definitions.
  void executeActions(
    BuildContext context,
    SpecModel? specModel,
    List<String>? actionIds,
  ) {
    if (actionIds == null ||
        actionIds.isEmpty ||
        specModel == null ||
        specModel.actions == null) {
      if (actionIds != null && actionIds.isNotEmpty) {
        print(
            "ActionHandler Error: Cannot execute actions - SpecModel or actions map is null.");
      }
      return; // No actions to execute or no spec/actions defined
    }

    final actionsMap = specModel.actions!;

    for (final actionId in actionIds) {
      final actionModel = actionsMap[actionId];
      if (actionModel == null) {
        print(
            "ActionHandler Error: Action with ID '$actionId' not found in spec.");
        continue; // Skip to the next action
      }

      // Execute the specific action based on its type
      _executeAction(context, actionModel);
    }
  }

  /// Executes a single action based on its model type.
  void _executeAction(BuildContext context, ActionModel actionModel) {
    print(
        "ActionHandler: Executing action '${actionModel.id}' of type '${actionModel.actionType}'");

    switch (actionModel) {
      case SetStateActionModel model:
        try {
          // Get the screen's Bloc instance
          final bloc = context.read<DevityScreenBloc>();
          // Dispatch the update event
          bloc.add(DevityScreenUpdateState(updates: model.updates));
        } catch (e) {
          // Handle cases where Bloc is not found (should not happen if setup correctly)
          print(
              "ActionHandler Error: Could not find DevityScreenBloc for SetState action '${actionModel.id}'. Error: $e");
        }
        break; // End of SetState case

      // TODO: Add cases for other action types like Navigate, ApiCall, etc.
      // case NavigateActionModel():
      //   // Use GoRouter or Navigator to navigate
      //   break;

      default:
        print(
            "ActionHandler Warning: Execution not implemented for action type '${actionModel.actionType}' (ID: ${actionModel.id})");
    }
  }
}
