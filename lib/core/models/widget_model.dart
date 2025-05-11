import 'package:devity_sdk/core/models/component_model.dart';

/// Base model for Widgets.
abstract class WidgetModel extends ComponentModel {
  // Add other common event hooks as needed

  WidgetModel({
    required String super.id,
    required this.widgetType,
    this.attributes = const {},
    super.style,
    this.onClickActionIds,
    this.onValueChangedActionIds,
  }) : super(type: 'Widget');

  final String widgetType;
  final Map<String, dynamic> attributes;
  final List<String>? onClickActionIds;
  final List<String>? onValueChangedActionIds;

  /// Concrete implementation of toJson for WidgetModel.
  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'id': id,
      'type': type,
      'widgetType': widgetType,
      'attributes': attributes,
    };
    if (super.style != null) {
      json['style'] = super.style!.toJson();
    }
    if (onClickActionIds != null) {
      json['onClickActionIds'] = onClickActionIds;
    }
    if (onValueChangedActionIds != null) {
      json['onValueChangedActionIds'] = onValueChangedActionIds;
    }
    return json;
  }
}
