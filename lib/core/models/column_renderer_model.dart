import 'package:devity_sdk/core/models/renderer_model.dart';

/// Represents a 'Column' layout renderer in the Devity spec.
class ColumnRendererModel extends RendererModel {
  // Add specific attributes for Column later if needed
  // e.g., final String? mainAxisAlignment;
  // e.g., final String? crossAxisAlignment;
  // e.g., final double? spacing;

  ColumnRendererModel({
    super.id,
    super.attributes,
    super.children,
    super.style,
  }) : super(
          rendererType: 'Column',
        );

  // Parsing is handled externally
}
