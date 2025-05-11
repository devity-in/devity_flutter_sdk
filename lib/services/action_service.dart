import 'package:devity_sdk/models/action_model.dart'; // Relative path from services to models
import 'package:devity_sdk/models/spec_model.dart'; // Relative path from services to models
import 'package:devity_sdk/services/action_handler.dart'; // For NavigationHandler typedef
import 'package:flutter/material.dart';

// TODO: Consider how to provide the GoRouter instance if used, or use Navigator.of(context)
// import 'package:go_router/go_router.dart';

class ActionService {
  // Added navigationHandler field

  ActionService(DevitySpec spec, {this.navigationHandler})
      : _actionsMap = spec.actions;
  // Changed DevitySpec to SpecModel to match DevityRoot
  // This requires SpecModel to have a compatible 'actions' property.
  final Map<String, DevityAction> _actionsMap;
  final NavigationHandler? navigationHandler;

  Future<void> executeActionById(String actionId, BuildContext context) async {
    final action = _actionsMap[actionId];
    if (action == null) {
      debugPrint("ActionService: Action with ID '$actionId' not found.");
      return;
    }
    await _executeAction(action, context);
  }

  Future<void> executeActionsByIds(
    List<String> actionIds,
    BuildContext context,
  ) async {
    for (final actionId in actionIds) {
      // Execute sequentially, awaiting each. Consider if parallel execution or error handling strategies are needed.
      await executeActionById(actionId, context);
    }
  }

  Future<void> _executeAction(
    DevityAction action,
    BuildContext context,
  ) async {
    switch (action.actionType) {
      case DevityActionType.navigate:
        if (action.attributes is NavigateActionAttributes) {
          await _handleNavigate(
            action.attributes as NavigateActionAttributes,
            context,
          );
        } else {
          debugPrint(
            'ActionService: Navigate action attributes type mismatch.',
          );
        }
      case DevityActionType.showAlert:
        if (action.attributes is ShowAlertActionAttributes) {
          await _handleShowAlert(
            action.attributes as ShowAlertActionAttributes,
            context,
          );
        } else {
          debugPrint(
            'ActionService: ShowAlert action attributes type mismatch.',
          );
        }
      case DevityActionType.unknown:
        debugPrint(
          'ActionService: Cannot execute action of unknown type: ${action.id}',
        );
    }
  }

  Future<void> _handleNavigate(
    NavigateActionAttributes attrs,
    BuildContext context,
  ) async {
    if (navigationHandler != null) {
      debugPrint(
        'ActionService: Navigating to ${attrs.targetScreenId} via NavigationHandler.',
      );
      // Calling the provided handler. clearHistory and screenData are ignored for now
      // if the handler only supports screenId.
      // TODO: Discuss enhancing NavigationHandler to support clearHistory and screenData.
      navigationHandler!(attrs.targetScreenId);
    } else {
      // Fallback or alternative if no handler provided, or if handler can't do complex nav.
      // This is where you might use Navigator.of(context) directly if needed.
      debugPrint(
        'ActionService: NavigationHandler not provided. Attempting basic navigation for ${attrs.targetScreenId}.',
      );
      // Example: Basic pushNamed. This assumes routes are named like screen IDs.
      // This might not be the desired behavior if an external handler is expected.
      try {
        if (Navigator.of(context).canPop() && attrs.clearHistory) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/${attrs.targetScreenId}', // Assuming route name matches screenId with a leading slash
            (route) => false,
            arguments: attrs.screenData,
          );
        } else {
          Navigator.of(context).pushNamed(
            '/${attrs.targetScreenId}', // Assuming route name matches screenId with a leading slash
            arguments: attrs.screenData,
          );
        }
      } catch (e) {
        debugPrint(
          'ActionService: Fallback navigation failed for ${attrs.targetScreenId}. Error: $e. Ensure routes are set up if using fallback.',
        );
      }
    }
    // Simulate async operation if needed for other parts of the action system
    await Future.delayed(const Duration(milliseconds: 10));
  }

  Future<void> _handleShowAlert(
    ShowAlertActionAttributes attrs,
    BuildContext context,
  ) async {
    debugPrint(
      'ActionService: Showing alert: Title: ${attrs.title}, Message: ${attrs.message}',
    );
    await showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: attrs.title != null ? Text(attrs.title!) : null,
          content: Text(attrs.message),
          actions: <Widget>[
            TextButton(
              child: Text(attrs.buttonText ?? 'OK'), // Default to OK
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
