import 'package:devity_sdk/core/models/style_model.dart';

/// Base class for all parsed components from the Spec JSON.
abstract class ComponentModel {
  ComponentModel({required this.type, this.id, this.style});

  /// Factory constructor to parse a component from JSON.
  /// Subclasses should implement specific parsing logic.
  /// This might be moved to the parser layer later.
  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    final styleJson = json['style'] as Map<String, dynamic>?;
    final styleModel = StyleModel.fromJson(styleJson);

    // TODO: Implement the full parsing logic here, calling specific subclass factories
    switch (type) {
      case 'Renderer':
        // Delegate to RendererModel.fromJson or specific types (Column, Row...)
        // return RendererModel.fromJson(json, styleModel); // Example
        throw UnimplementedError(
            'Renderer parsing not fully implemented in ComponentModel.fromJson');
      case 'Widget':
        // Delegate to WidgetModel.fromJson or specific types (Text, Button...)
        // return WidgetModel.fromJson(json, styleModel); // Example
        throw UnimplementedError(
            'Widget parsing not fully implemented in ComponentModel.fromJson');
      // Add cases for 'Screen', 'Action', etc. if they are ComponentModels
      default:
        print("Error: Unknown component type '$type' in JSON: $json");
        throw FormatException('Unknown component type: $type');
    }
  }

  /// Unique identifier for the component within the spec.
  /// Might be null for components that don't need direct referencing.
  final String? id;

  /// The type of the component (e.g., Screen, Renderer, Widget, Action).
  final String type;

  final StyleModel? style;
}
