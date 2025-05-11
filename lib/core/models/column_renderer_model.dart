import 'package:devity_sdk/core/models/component_model.dart';
import 'package:devity_sdk/core/models/renderer_model.dart';
import 'package:devity_sdk/core/models/style_model.dart'; // For StyleModel.fromJson

/// Represents a 'Column' layout renderer in the Devity spec.
class ColumnRendererModel extends RendererModel {
  // Add specific attributes for Column later if needed
  // e.g., final String? mainAxisAlignment;
  // e.g., final String? crossAxisAlignment;
  // e.g., final double? spacing;

  ColumnRendererModel({
    super.id,
    super.attributes, // These are generic attributes from RendererModel
    super.children,
    super.style,
  }) : super(
          rendererType: 'Column',
        );

  factory ColumnRendererModel.fromJson(Map<String, dynamic> json) {
    return ColumnRendererModel(
      id: json['id'] as String?,
      style: json.containsKey('style') && json['style'] != null
          ? StyleModel.fromJson(json['style'] as Map<String, dynamic>)
          : null,
      attributes: json['props'] as Map<String,
              dynamic>? ?? // Prefer 'props' for renderer-specific, else root
          json['attributes'] as Map<String, dynamic>? ??
          const {},
      children: json.containsKey('children') && json['children'] is List
          ? (json['children'] as List<dynamic>)
              .map((childJson) =>
                  ComponentModel.fromJson(childJson as Map<String, dynamic>))
              .toList()
          : const [],
      // Parse specific Column attributes here if they exist, e.g.:
      // mainAxisAlignment: json['props']?['mainAxisAlignment'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'id': id,
      'type': type, // from ComponentModel (should be 'Renderer')
      'rendererType': rendererType, // from RendererModel (should be 'Column')
      'style': style?.toJson(),
      'props': attributes, // Use 'props' for renderer-specific attributes
      'children': children.map((child) => child.toJson()).toList(),
    };
    // Remove null id, style, props if they are empty, to keep JSON clean
    json.removeWhere((key, value) =>
        value == null || (value is Map && value.isEmpty && key == 'props'));
    return json;
  }
}
