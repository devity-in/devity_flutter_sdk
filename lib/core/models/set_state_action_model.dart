import 'package:devity_sdk/core/models/action_model.dart';

/// Model representing a 'setState' action.
class SetStateActionModel extends ActionModel {
  SetStateActionModel({
    required super.id,
    required this.updates,
  }) : super(actionType: 'setState');

  /// The map of key-value pairs representing the state updates.
  final Map<String, dynamic> updates; // Set actionType in super constructor

  // Optional: Add fromJson/toJson if needed for specific parsing/serialization
  /*
  factory SetStateActionModel.fromJson(String id, Map<String, dynamic> json) {
    return SetStateActionModel(
      id: id,
      updates: json['params'] as Map<String, dynamic>? ?? {},
    );
  }
  */

  @override
  Map<String, dynamic> toJson() {
    // It's important to get the base serialization from ActionModel if it handles common fields.
    // However, ActionModel doesn't implement toJson(), ComponentModel defines it abstractly.
    // So we need to construct the full JSON here or ensure ActionModel implements toJson().
    // For now, let's assume ActionModel might get a toJson() or we build it fully.
    // The provided error indicates ComponentModel.toJson is missing, so ActionModel also misses it.

    // Re-evaluating: The ShowAlertActionModel.toJson() was implemented by including all necessary fields.
    // We should do the same here for consistency and to ensure all fields from the hierarchy are present.
    return {
      'id': id, // from ComponentModel
      'type':
          type, // from ComponentModel (set to 'Action' in ActionModel constructor)
      'actionType':
          actionType, // from ActionModel (set to 'setState' in this constructor)
      'params':
          updates, // Specific to SetStateActionModel, using 'params' as key like in fromJson
      // 'attributes': attributes, // If ActionModel had its own attributes to serialize distinct from 'params'
    };
  }
}
