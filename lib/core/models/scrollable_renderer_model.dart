import 'package:devity_sdk/core/models/component_model.dart';
import 'package:devity_sdk/core/models/renderer_model.dart';
import 'package:devity_sdk/core/models/style_model.dart';
import 'package:flutter/material.dart'; // For Axis

/// Represents a 'Scrollable' renderer in the Devity spec.
///
/// This renderer makes its single child scrollable, either vertically or horizontally.
class ScrollableRendererModel extends RendererModel {
  ScrollableRendererModel({
    required ComponentModel child,
    super.id,
    this.scrollDirection = Axis.vertical, // Default to vertical
    Map<String, dynamic>? attributes, // Make attributes optional
    super.style,
  }) : super(
          rendererType: 'Scrollable',
          children: [child],
          attributes: attributes ?? const {}, // Ensure attributes not null
        ) {
    assert(
      children.length == 1,
      'ScrollableRendererModel must have exactly one child.',
    );
  }

  factory ScrollableRendererModel.fromJson(Map<String, dynamic> json) {
    final props = json['props'] as Map<String, dynamic>? ?? {};
    final rawChildren = json['children'] as List<dynamic>?;

    if (rawChildren == null || rawChildren.isEmpty) {
      throw const FormatException(
          'ScrollableRendererModel requires exactly one child, but found none.');
    }
    if (rawChildren.length > 1) {
      print(
          'Warning: ScrollableRendererModel expects one child, but found ${rawChildren.length}. Using the first one.');
    }

    final directionString = props['scrollDirection'] as String?;
    final direction = (directionString?.toLowerCase() == 'horizontal')
        ? Axis.horizontal
        : Axis.vertical; // Default to vertical

    return ScrollableRendererModel(
      id: json['id'] as String?,
      style: json.containsKey('style') && json['style'] != null
          ? StyleModel.fromJson(json['style'] as Map<String, dynamic>)
          : null,
      child: ComponentModel.fromJson(rawChildren.first as Map<String, dynamic>),
      scrollDirection: direction,
      attributes: props, // Pass all props as general attributes
    );
  }

  /// Factory constructor for JSON parsing - simplified assumption.
  /// Assumes parsing logic is handled externally, but provides a way to create
  /// the model *after* attributes have been parsed by the caller.
  factory ScrollableRendererModel.fromParsedAttributes({
    required ComponentModel child,
    required Map<String, dynamic> attributes,
    String? id,
    StyleModel? style, // Added style
  }) {
    final directionString = attributes['scrollDirection'] as String?;
    final direction = (directionString?.toLowerCase() == 'horizontal')
        ? Axis.horizontal
        : Axis.vertical; // Default to vertical

    return ScrollableRendererModel(
      id: id,
      child: child,
      scrollDirection: direction,
      attributes: attributes, // Keep original attributes
      style: style, // Pass style
    );
  }

  final Axis scrollDirection;

  /// Convenience getter for the single child.
  ComponentModel get child => children.first;

  @override
  Map<String, dynamic> toJson() {
    final currentProps = Map<String, dynamic>.from(attributes);
    currentProps['scrollDirection'] =
        scrollDirection == Axis.horizontal ? 'horizontal' : 'vertical';

    final jsonMap = <String, dynamic>{
      'id': id,
      'type': type,
      'rendererType': rendererType,
      'style': style?.toJson(),
      'props': currentProps,
      'children': children.map((c) => c.toJson()).toList(),
    };
    jsonMap.removeWhere((key, value) =>
        value == null || (value is Map && value.isEmpty && key == 'props'));
    return jsonMap;
  }
}
