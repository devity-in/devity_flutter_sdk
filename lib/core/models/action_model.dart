import './component_model.dart';

/// Base model for Actions.
abstract class ActionModel extends ComponentModel {
  final String actionType;
  final Map<String, dynamic>? attributes;

  ActionModel({
    required String id,
    required this.actionType,
    this.attributes,
  }) : super(id: id, type: 'Action');

  // Placeholder for parsing - Specific actions will implement
  // static ActionModel fromJson(String id, Map<String, dynamic> json);
}
