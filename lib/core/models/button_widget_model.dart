import 'package:devity_sdk/core/models/style_model.dart';
import 'package:devity_sdk/core/models/widget_model.dart';

/// Model representing a basic Button widget.
class ButtonWidgetModel extends WidgetModel {
  // TODO: Add button-specific style properties (e.g., buttonColor, textColor)?

  ButtonWidgetModel({
    required super.id,
    required this.text,
    this.enabled = true,
    super.style,
    super.onClickActionIds,
    // No onValueChanged for basic button
  }) : super(
          widgetType: 'Button',
          attributes: {
            'text': text,
            'enabled': enabled,
          },
          onValueChangedActionIds: null,
        );

  factory ButtonWidgetModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
    final styleJson = json['style'] as Map<String, dynamic>?;
    return ButtonWidgetModel(
      id: json['id'] as String,
      text: attributes['text'] as String? ?? 'Button',
      enabled: attributes['enabled'] as bool? ?? true,
      style: styleJson != null ? StyleModel.fromJson(styleJson) : null,
      onClickActionIds: (json['onClickActionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
  final String text;
  final bool enabled;

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson(); // Get base fields
    json['widgetType'] = 'Button'; // Ensure type is correct
    json['attributes'] = {'text': text}; // Add specific attributes
    // Merge existing style if needed
    return json;
  }
}
