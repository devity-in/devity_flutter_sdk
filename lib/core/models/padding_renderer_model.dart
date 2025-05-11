import 'package:devity_sdk/core/models/component_model.dart';
import 'package:devity_sdk/core/models/padding_value.dart';
import 'package:devity_sdk/core/models/renderer_model.dart';
import 'package:devity_sdk/core/models/style_model.dart';

/// Represents a 'Padding' renderer in the Devity spec.
///
/// This renderer applies padding around a single child component.
class PaddingRendererModel extends RendererModel {
  PaddingRendererModel({
    required this.padding,
    required ComponentModel child,
    super.id,
    Map<String, dynamic>?
        attributes, // Make attributes optional for constructor
    super.style,
  }) : super(
          rendererType: 'Padding',
          children: [child],
          attributes: attributes ?? const {}, // Ensure attributes is not null
        ) {
    assert(
      children.length == 1,
      'PaddingRendererModel must have exactly one child.',
    );
  }

  factory PaddingRendererModel.fromJson(Map<String, dynamic> json) {
    final props = json['props'] as Map<String, dynamic>? ?? {};
    final rawChildren = json['children'] as List<dynamic>?;

    if (rawChildren == null || rawChildren.isEmpty) {
      throw const FormatException(
          'PaddingRendererModel requires exactly one child, but found none.');
    }
    if (rawChildren.length > 1) {
      print(
          'Warning: PaddingRendererModel expects one child, but found ${rawChildren.length}. Using the first one.');
    }

    return PaddingRendererModel(
      id: json['id'] as String?,
      style: json.containsKey('style') && json['style'] != null
          ? StyleModel.fromJson(json['style'] as Map<String, dynamic>)
          : null,
      padding: PaddingValue.fromJson(
          props['padding'] as Map<String, dynamic>? ?? {}),
      child: ComponentModel.fromJson(rawChildren.first as Map<String, dynamic>),
      attributes: props, // Pass all props as general attributes
    );
  }
  final PaddingValue padding;

  /// Convenience getter for the single child.
  ComponentModel get child => children.first;

  @override
  Map<String, dynamic> toJson() {
    final currentProps =
        Map<String, dynamic>.from(attributes); // Start with existing attributes
    currentProps['padding'] = padding.toJson();

    final jsonMap = <String, dynamic>{
      'id': id,
      'type': type,
      'rendererType': rendererType,
      'style': style?.toJson(),
      'props': currentProps,
      'children': children
          .map((c) => c.toJson())
          .toList(), // Should be a list with one child
    };
    jsonMap.removeWhere((key, value) =>
        value == null || (value is Map && value.isEmpty && key == 'props'));
    return jsonMap;
  }

  // Parsing is handled externally. The parser should create the PaddingValue
  // and the child ComponentModel instance before creating this PaddingRendererModel.
}
