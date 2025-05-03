import 'package:devity_sdk/core/models/component_model.dart';
import 'package:devity_sdk/core/models/style_model.dart';

/// Base model for Widgets.
abstract class WidgetModel extends ComponentModel {
  // Add other common event hooks as needed

  WidgetModel({
    required String id,
    required this.widgetType,
    this.attributes = const {},
    this.style,
    this.onClickActionIds,
    this.onValueChangedActionIds,
  }) : super(id: id, type: 'Widget', style: style);
  final String widgetType;
  final Map<String, dynamic> attributes;
  @override
  final StyleModel? style;
  final List<String>? onClickActionIds;
  final List<String>? onValueChangedActionIds;
}
