import './component_model.dart';

/// Base model for Renderers.
abstract class RendererModel extends ComponentModel {
  final String rendererType;
  final Map<String, dynamic>? attributes;
  final Map<String, dynamic>? style; // Placeholder for StyleModel
  final List<ComponentModel> children;

  RendererModel({
    String? id,
    required this.rendererType,
    this.attributes,
    this.style,
    required this.children,
  }) : super(id: id, type: 'Renderer');
}
