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
    Map<String, dynamic>? // Allow passing raw attributes if needed by parser
        rawAttributes,
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
  final String? initialValue;
  final String? label;
  final String? placeholder;
  final String? keyboardType;
  final bool obscureText;
}
