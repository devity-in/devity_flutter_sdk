import 'package:devity_sdk/core/models/component_model.dart';

/// Model for Rules.
class RuleModel extends ComponentModel {
  RuleModel({
    required String id,
    required this.trigger,
    required this.conditionExpression,
    required this.actionIds,
  }) : super(id: id, type: 'Rule');

  // Placeholder for parsing
  factory RuleModel.fromJson(String id, Map<String, dynamic> json) {
    // TODO: Implement more robust parsing
    return RuleModel(
      id: id,
      // Safely cast trigger, default to empty map
      trigger: (json['trigger'] as Map<String, dynamic>?) ?? {},
      // Safely cast conditionExpression, default to empty string
      conditionExpression: (json['condition'] as String?) ?? '',
      // Safely cast actionIds, default to empty list
      actionIds: (json['actionIds'] as List<dynamic>? ?? []).cast<String>(),
    );
  }
  // TODO: Define properties for trigger, condition (expression), actionIds
  final Map<String, dynamic> trigger; // Placeholder
  final String conditionExpression; // Placeholder
  final List<String> actionIds;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'trigger': trigger,
      'condition': conditionExpression, // Match the fromJson key 'condition'
      'actionIds': actionIds,
    };
  }
}
