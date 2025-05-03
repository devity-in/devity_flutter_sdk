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
    super.attributes, // Store original attributes
    super.style, // Added style
  }) : super(
          rendererType: 'Scrollable',
          children: [child], // Pass style
        ) {
    assert(children.length == 1,
        'ScrollableRendererModel must have exactly one child.');
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

  // Full external parsing needed for children and potentially style.
}
