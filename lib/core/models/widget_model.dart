import './component_model.dart';

/// Base model for Widgets.
abstract class WidgetModel extends ComponentModel {
  final String widgetType;
  final Map<String, dynamic> attributes;
  final Map<String, dynamic>? style; // Placeholder for StyleModel
  final List<String>? onClickActionIds;
  final List<String>? onValueChangedActionIds;
  // Add other common event hooks as needed

  WidgetModel({
    required String id,
    required this.widgetType,
    required this.attributes,
    this.style,
    this.onClickActionIds,
    this.onValueChangedActionIds,
  }) : super(id: id, type: 'Widget');
}
