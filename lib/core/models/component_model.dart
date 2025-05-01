/// Base class for all parsed components from the Spec JSON.
abstract class ComponentModel {
  /// Unique identifier for the component within the spec.
  /// Might be null for components that don't need direct referencing.
  final String? id;

  /// The type of the component (e.g., Screen, Renderer, Widget, Action).
  final String type;

  ComponentModel({this.id, required this.type});

  /// Factory constructor to parse a component from JSON.
  /// Subclasses should implement specific parsing logic.
  /// This might be moved to the parser layer later.
  // static ComponentModel fromJson(Map<String, dynamic> json) {
  //   final type = json['type'] as String?;
  //   switch (type) {
  //     case 'Screen':
  //       return ScreenModel.fromJson(json);
  //     // ... other types
  //     default:
  //       throw UnimplementedError('Unknown component type: $type');
  //   }
  // }
}
