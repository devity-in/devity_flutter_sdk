import './widget_model.dart';

class TextWidgetModel extends WidgetModel {
  // Specific attributes for Text
  final String text;
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  // Add others like textAlign, maxLines etc. based on schema

  TextWidgetModel({
    required String id,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    Map<String, dynamic>? style,
    List<String>? onClickActionIds,
    // Note: attributes map from base class is not used directly here
    // Specific attributes are defined as fields for type safety.
    // The parser will populate these fields from the attributes map.
  }) : super(
          id: id,
          widgetType: 'Text',
          attributes: {
            // Reconstruct attributes map if needed, or handle in base
            'text': text,
            if (fontSize != null) 'fontSize': fontSize,
            if (fontWeight != null) 'fontWeight': fontWeight,
            if (color != null) 'color': color,
          },
          style: style,
          onClickActionIds: onClickActionIds,
        );
}
