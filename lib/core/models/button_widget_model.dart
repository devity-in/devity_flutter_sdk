import 'package:devity_sdk/core/models/widget_model.dart';

/// Model representing a basic Button widget.
class ButtonWidgetModel extends WidgetModel {
  final String text;
  // TODO: Add button-specific style properties (e.g., buttonColor, textColor)?

  ButtonWidgetModel({
    required String id,
    required this.text,
    Map<String, dynamic>? style,
    List<String>? onClickActionIds,
    // No onValueChanged for basic button
  }) : super(
          id: id,
          widgetType: 'Button',
          attributes: {'text': text},
          style: style,
          onClickActionIds: onClickActionIds,
          onValueChangedActionIds: null,
        );

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
