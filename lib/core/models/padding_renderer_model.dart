import 'package:devity_sdk/core/models/component_model.dart';
import 'package:devity_sdk/core/models/padding_value.dart';
import 'package:devity_sdk/core/models/renderer_model.dart';

/// Represents a 'Padding' renderer in the Devity spec.
///
/// This renderer applies padding around a single child component.
class PaddingRendererModel extends RendererModel {
  PaddingRendererModel({
    required this.padding,
    required ComponentModel child,
    super.id,
    Map<String, dynamic> super.attributes =
        const {}, // Keep original attributes if needed
    // StyleModel? style, // Removed for now
  }) : super(
          rendererType: 'Padding',
          children: [child], // Padding renderer has exactly one child
          // style: style, // Removed for now
        ) {
    assert(children.length == 1,
        'PaddingRendererModel must have exactly one child.');
  }
  final PaddingValue padding;

  /// Convenience getter for the single child.
  ComponentModel get child => children.first;

  // Parsing is handled externally. The parser should create the PaddingValue
  // and the child ComponentModel instance before creating this PaddingRendererModel.
}
