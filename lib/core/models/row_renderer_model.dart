import 'package:devity_sdk/core/models/component_model.dart';
import 'package:devity_sdk/core/models/renderer_model.dart';
import 'package:devity_sdk/core/models/style_model.dart'; // For StyleModel.fromJson

/// Represents a 'Row' layout renderer in the Devity spec.
class RowRendererModel extends RendererModel {
  // TODO: Add specific attributes for Row (e.g., mainAxisAlignment, crossAxisAlignment)

  RowRendererModel({
    super.id,
    super.attributes,
    super.children,
    super.style,
  }) : super(
          rendererType: 'Row',
        );

  factory RowRendererModel.fromJson(Map<String, dynamic> json) {
    return RowRendererModel(
      id: json['id'] as String?,
      style: json.containsKey('style') && json['style'] != null
          ? StyleModel.fromJson(json['style'] as Map<String, dynamic>)
          : null,
      attributes: json['props'] as Map<String, dynamic>? ??
          json['attributes'] as Map<String, dynamic>? ??
          const {},
      children: json.containsKey('children') && json['children'] is List
          ? (json['children'] as List<dynamic>)
              .map((childJson) =>
                  ComponentModel.fromJson(childJson as Map<String, dynamic>))
              .toList()
          : const [],
      // Parse specific Row attributes here if they exist
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'id': id,
      'type': type,
      'rendererType': rendererType,
      'style': style?.toJson(),
      'props': attributes,
      'children': children.map((child) => child.toJson()).toList(),
    };
    json.removeWhere((key, value) =>
        value == null || (value is Map && value.isEmpty && key == 'props'));
    return json;
  }

  // Parsing is handled externally, likely in DevityParser or DevityRenderer
}
