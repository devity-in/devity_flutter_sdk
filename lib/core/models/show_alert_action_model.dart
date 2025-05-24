import 'package:devity_sdk/core/models/action_model.dart';

/// Action model for displaying a simple alert dialog.
class ShowAlertActionModel extends ActionModel {
  // TODO: Add optional button text/actions?

  ShowAlertActionModel({
    required super.id,
    required this.title,
    required this.message,
    Map<String, dynamic>? attributes, // Keep base attributes if needed
  }) : super(
          actionType: 'ShowAlert',
          // Pass specific attributes needed by base or parser
          attributes: {'title': title, 'message': message, ...?attributes},
        );

  /// The title of the alert dialog.
  final String title;

  /// The message content of the alert dialog.
  final String message;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type, // 'Action' from ActionModel
      'actionType': actionType, // 'ShowAlert'
      'attributes': attributes, // Contains title and message
    };
  }
}
