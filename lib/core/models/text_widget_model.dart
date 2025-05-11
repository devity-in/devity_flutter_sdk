import 'package:devity_sdk/core/models/style_model.dart';
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
    this.textAlign,
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
            if (textAlign != null) 'textAlign': textAlign,
          },
        );

  factory TextWidgetModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
    final styleJson = json['style'] as Map<String, dynamic>?;
    return TextWidgetModel(
      id: json['id'] as String,
      text: attributes['text'] as String? ?? '',
      fontSize: (attributes['fontSize'] as num?)?.toDouble(),
      fontWeight: attributes['fontWeight'] as String?,
      color: attributes['color'] as String?,
      textAlign: attributes['textAlign'] as String?,
      style: styleJson != null ? StyleModel.fromJson(styleJson) : null,
      onClickActionIds: (json['onClickActionIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
  // Specific attributes for Text
  final String text;
  final double? fontSize;
  final String? fontWeight;
  final String? color;
  final String? textAlign;
  // toJson is handled by WidgetModel.toJson() which includes 'attributes' map.
}
