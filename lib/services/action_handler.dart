import 'package:devity_sdk/core/core.dart';
import 'package:devity_sdk/core/models/set_state_action_model.dart';
import 'package:devity_sdk/core/models/navigate_action_model.dart';
import 'package:devity_sdk/core/models/show_alert_action_model.dart';
import 'package:devity_sdk/state/devity_screen_bloc.dart';
import 'package:devity_sdk/state/devity_screen_event.dart';
import 'package:flutter/widgets.dart'; // Need BuildContext
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart'; // Import material for showDialog

/// Callback function signature for handling navigation requests from the SDK.
/// The app using the SDK should implement this to perform actual navigation.
typedef NavigationHandler = void Function(String screenId);

// TODO: Consider making this injectable or accessed via context
class ActionHandler {
  /// Optional handler for navigation actions.
  final NavigationHandler? navigationHandler;

  // Constructor to accept the handler (if we decide to inject later)
  ActionHandler({this.navigationHandler});

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

      case NavigateActionModel model:
        if (navigationHandler != null) {
          navigationHandler!(model.screenId);
        } else {
          print(
              "ActionHandler Warning: Navigate action '${model.id}' executed, but no NavigationHandler was provided to DevityRoot.");
        }
        break; // End of Navigate case

      case ShowAlertActionModel model:
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text(model.title),
              content: Text(model.message),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert
                  },
                ),
              ],
            );
          },
        );
        break; // End of ShowAlert case

      default:
        print(
            "ActionHandler Warning: Execution not implemented for action type '${actionModel.actionType}' (ID: ${actionModel.id})");
    }
  }
}
