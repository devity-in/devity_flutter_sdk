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
  /// Optional [eventPayload] can provide context from the triggering event (e.g., widget value).
  void executeActions(
      BuildContext context, SpecModel? specModel, List<String>? actionIds,
      {Map<String, dynamic>? eventPayload} // Add optional payload
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

      // Execute the specific action based on its type, passing payload
      _executeAction(context, actionModel, eventPayload: eventPayload);
    }
  }

  /// Executes a single action based on its model type.
  void _executeAction(BuildContext context, ActionModel actionModel,
      {Map<String, dynamic>? eventPayload} // Add optional payload
      ) {
    print(
        "ActionHandler: Executing action '${actionModel.id}' of type '${actionModel.actionType}'" +
            (eventPayload != null ? " with payload: $eventPayload" : ""));

    switch (actionModel) {
      case SetStateActionModel model:
        // Process updates to substitute payload values if necessary
        Map<String, dynamic> processedUpdates = {};
        model.updates.forEach((key, value) {
          if (value is String && value == '@{event.value}') {
            // Substitute with payload value if key exists, otherwise use null or empty?
            // Let's use null if not found, assuming the state can handle it.
            processedUpdates[key] = eventPayload?['value'];
            print(
                "ActionHandler: Substituted @{event.value} for key '$key' with value: ${processedUpdates[key]}");
          } else {
            // Keep original value if not a substitution placeholder
            processedUpdates[key] = value;
          }
        });

        try {
          final bloc = context.read<DevityScreenBloc>();
          // Dispatch the update event with processed updates
          bloc.add(DevityScreenUpdateState(updates: processedUpdates));
        } catch (e) {
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
