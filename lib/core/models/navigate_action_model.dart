import 'package:devity_sdk/core/models/action_model.dart';

/// Action model for navigating to a different screen.
class NavigateActionModel extends ActionModel {
  NavigateActionModel({
    required super.id,
    required this.screenId,
    Map<String, dynamic>? attributes, // Keep base attributes if needed
  }) : super(
          actionType: 'Navigate',
          // Pass specific attributes needed by base or parser
          attributes: {'screenId': screenId, ...?attributes},
        );

  /// The ID of the screen to navigate to.
  final String screenId;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type, // 'Action' from ActionModel
      'actionType': actionType, // 'Navigate'
      'attributes':
          attributes, // Contains screenId and any other base attributes
    };
  }
}
