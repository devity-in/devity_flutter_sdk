import 'package:devity_sdk/core/models/style_model.dart';
import 'package:devity_sdk/core/models/widget_model.dart';

/// Model representing a TextField widget.
class TextFieldWidgetModel extends WidgetModel {
  // Inherits onValueChangedActionIds from WidgetModel

  TextFieldWidgetModel({
    required super.id,
    this.initialValue,
    this.label,
    this.placeholder,
    this.keyboardType,
    this.obscureText = false,
    super.style,
    super.onValueChangedActionIds,
    Map<String, dynamic>?
        rawAttributes, // Keep for flexibility if DevityParser uses it
  }) : super(
          widgetType: 'TextField',
          attributes: {
            // Reconstruct attributes map for base class / potential serialization
            if (initialValue != null) 'initialValue': initialValue,
            if (label != null) 'label': label,
            if (placeholder != null) 'placeholder': placeholder,
            if (keyboardType != null) 'keyboardType': keyboardType,
            'obscureText': obscureText,
            // Include any other raw attributes passed
            ...?rawAttributes,
          },
          // TextField doesn't typically have onClick
          onClickActionIds: null,
        );

  factory TextFieldWidgetModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
    final styleJson = json['style'] as Map<String, dynamic>?;
    return TextFieldWidgetModel(
      id: json['id'] as String,
      initialValue: attributes['initialValue'] as String?,
      label: attributes['label'] as String?,
      placeholder: attributes['placeholder'] as String?,
      keyboardType: attributes['keyboardType'] as String?,
      obscureText: attributes['obscureText'] as bool? ?? false,
      style: styleJson != null ? StyleModel.fromJson(styleJson) : null,
      onValueChangedActionIds:
          (json['onValueChangedActionIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      // Pass all attributes from JSON to rawAttributes if constructor needs them for full map.
      // Or, ensure the constructor logic for 'attributes' map is comprehensive.
      rawAttributes:
          attributes, // This ensures attributes map in super is complete
    );
  }
  final String? initialValue;
  final String? label;
  final String? placeholder;
  final String? keyboardType;
  final bool obscureText;
  // toJson is handled by WidgetModel.toJson()
}
