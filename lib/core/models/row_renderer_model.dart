import 'package:devity_sdk/core/models/renderer_model.dart';

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

  // Parsing is handled externally, likely in DevityParser or DevityRenderer
}
