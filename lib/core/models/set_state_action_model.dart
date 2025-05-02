import 'package:devity_sdk/core/models/action_model.dart';

/// Model representing a 'setState' action.
class SetStateActionModel extends ActionModel {
  /// The map of key-value pairs representing the state updates.
  final Map<String, dynamic> updates;

  SetStateActionModel({
    required super.id,
    required this.updates,
  }) : super(actionType: 'setState'); // Set actionType in super constructor

  // Optional: Add fromJson/toJson if needed for specific parsing/serialization
  /*
  factory SetStateActionModel.fromJson(String id, Map<String, dynamic> json) {
    return SetStateActionModel(
      id: id,
      updates: json['params'] as Map<String, dynamic>? ?? {},
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['params'] = updates;
    return json;
  }
  */
}
