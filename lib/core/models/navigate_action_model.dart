import 'package:devity_sdk/core/models/action_model.dart';

/// Action model for navigating to a different screen.
class NavigateActionModel extends ActionModel {
  /// The ID of the screen to navigate to.
  final String screenId;

  NavigateActionModel({
    required String id,
    required this.screenId,
    Map<String, dynamic>? attributes, // Keep base attributes if needed
  }) : super(
          id: id,
          actionType: 'Navigate',
          // Pass specific attributes needed by base or parser
          attributes: {'screenId': screenId, ...?attributes},
        );
}
