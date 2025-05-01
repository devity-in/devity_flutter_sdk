import './component_model.dart';
import './renderer_model.dart';

class ColumnRendererModel extends RendererModel {
  // Add specific attributes for Column later if needed
  // e.g., final String? mainAxisAlignment;
  // e.g., final String? crossAxisAlignment;
  // e.g., final double? spacing;

  ColumnRendererModel({
    String? id,
    Map<String, dynamic>? attributes,
    Map<String, dynamic>? style,
    required List<ComponentModel> children,
  }) : super(
          id: id,
          rendererType: 'Column',
          attributes: attributes,
          style: style,
          children: children,
        );
}
