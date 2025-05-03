import 'package:devity_sdk/core/models/component_model.dart';

/// Base model for Renderers.
abstract class RendererModel extends ComponentModel {
  RendererModel({
    required this.rendererType,
    String? id,
    this.attributes = const {},
    this.children = const [],
    super.style, // Added style parameter
  }) : super(type: 'Renderer');
  final String rendererType;
  final Map<String, dynamic> attributes; // Raw attributes for specific types
  final List<ComponentModel> children; // Pass style to super

  // Parsing logic should ideally be centralized or handled by specific subclasses
}
