import 'package:devity_sdk/core/models/component_model.dart';
import 'package:devity_sdk/core/models/style_model.dart'; // Required for style parsing

/// Model for Screens.
class ScreenModel extends ComponentModel {
  ScreenModel({
    required String super.id,
    required this.body,
    String? type, // Type is 'Screen', set in super
    this.backgroundColor,
    this.appBar,
    this.bottomNavBar,
    this.onLoadActions,
    this.persistentData,
    super.style,
  }) : super(type: type ?? 'Screen');

  factory ScreenModel.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final type = json['type'] as String? ?? 'Screen'; // Ensure type is 'Screen'
    if (type != 'Screen') {
      throw FormatException('Invalid type for ScreenModel: $type');
    }

    final styleJson = json['style'] as Map<String, dynamic>?;
    final style = styleJson != null ? StyleModel.fromJson(styleJson) : null;

    ComponentModel? parseComponent(dynamic componentJson) {
      if (componentJson == null) return null;
      if (componentJson is Map<String, dynamic>) {
        return ComponentModel.fromJson(componentJson);
      }
      // Handle cases where it might be a string ID to be resolved later, or other formats.
      // For now, expect a map.
      print(
          'Warning: Expected Map<String, dynamic> for component, got ${componentJson.runtimeType}');
      return null; // Or throw error
    }

    return ScreenModel(
      id: id,
      type: type, // Pass type to super constructor
      backgroundColor: json['backgroundColor'] as String?,
      appBar: parseComponent(json['appBar']),
      body: parseComponent(json['body'])!, // Body is required
      bottomNavBar: parseComponent(json['bottomNavBar']),
      onLoadActions: (json['onLoadActions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      persistentData: json['persistentData'] as Map<String, dynamic>?,
      style: style,
    );
  }
  final String? backgroundColor;
  final ComponentModel? appBar; // Can be Widget or Renderer
  final ComponentModel body; // Can be Widget or Renderer
  final ComponentModel? bottomNavBar; // Can be Widget or Renderer
  final List<String>? onLoadActions;
  final Map<String, dynamic>? persistentData;

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'id': id,
      'type': type, // Should be 'Screen'
    };
    if (style != null) {
      data['style'] = style!.toJson();
    }
    if (backgroundColor != null) {
      data['backgroundColor'] = backgroundColor;
    }
    if (appBar != null) {
      data['appBar'] = appBar!.toJson();
    }
    data['body'] = body.toJson(); // Body is required
    if (bottomNavBar != null) {
      data['bottomNavBar'] = bottomNavBar!.toJson();
    }
    if (onLoadActions != null) {
      data['onLoadActions'] = onLoadActions;
    }
    if (persistentData != null) {
      data['persistentData'] = persistentData;
    }
    return data;
  }
}
