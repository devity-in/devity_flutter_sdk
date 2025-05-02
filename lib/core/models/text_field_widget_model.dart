import 'package:devity_sdk/core/models/widget_model.dart';

/// Model representing a TextField widget.
class TextFieldWidgetModel extends WidgetModel {
  final String? initialValue;
  final String? label;
  final String? placeholder;
  // Inherits onValueChangedActionIds from WidgetModel

  TextFieldWidgetModel({
    required String id,
    this.initialValue,
    this.label,
    this.placeholder,
    Map<String, dynamic>? style,
    List<String>? onValueChangedActionIds,
    Map<String, dynamic>? // Allow passing raw attributes if needed by parser
        rawAttributes,
  }) : super(
          id: id,
          widgetType: 'TextField',
          attributes: {
            // Reconstruct attributes map for base class / potential serialization
            if (initialValue != null) 'initialValue': initialValue,
            if (label != null) 'label': label,
            if (placeholder != null) 'placeholder': placeholder,
            // Include any other raw attributes passed
            ...?rawAttributes,
          },
          style: style,
          onValueChangedActionIds: onValueChangedActionIds,
          // TextField doesn't typically have onClick
          onClickActionIds: null,
        );
}
