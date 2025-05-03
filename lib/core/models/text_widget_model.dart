import 'package:devity_sdk/core/models/widget_model.dart';

/// Model representing a basic Text widget.
class TextWidgetModel extends WidgetModel {
  // Add others like textAlign, maxLines etc. based on schema

  TextWidgetModel({
    required super.id,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    super.style,
    super.onClickActionIds,
    // Note: attributes map from base class is not used directly here
    // Specific attributes are defined as fields for type safety.
    // The parser will populate these fields from the attributes map.
  }) : super(
          widgetType: 'Text',
          attributes: {
            // Reconstruct attributes map if needed, or handle in base
            'text': text,
            if (fontSize != null) 'fontSize': fontSize,
            if (fontWeight != null) 'fontWeight': fontWeight,
            if (color != null) 'color': color,
          },
        );
  // Specific attributes for Text
  final String text;
  final double? fontSize;
  final String? fontWeight;
  final String? color;
}
