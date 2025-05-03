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
  final String text;
  final bool enabled;

  // If needed later for specific parsing/serialization:
  /*
  factory ButtonWidgetModel.fromJson(Map<String, dynamic> json) {
    // Extract common fields using base class logic if possible
    // Parse specific fields like 'text' from attributes
    final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
    return ButtonWidgetModel(
      id: json['id'] as String,
      text: attributes['text'] as String? ?? 'Button',
      style: json['style'] as Map<String, dynamic>?,
      onClickActionIds: (json['onClickActionIds'] as List<dynamic>? ?? []).cast<String>(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
     final json = super.toJson(); // Get base fields
     json['widgetType'] = 'Button'; // Ensure type is correct
     json['attributes'] = { 'text': text }; // Add specific attributes
     // Merge existing style if needed
     return json;
  }
  */
}
