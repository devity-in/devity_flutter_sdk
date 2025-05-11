import 'package:devity_sdk/core/models/button_widget_model.dart';
// Import Renderer models
import 'package:devity_sdk/core/models/column_renderer_model.dart';
import 'package:devity_sdk/core/models/image_widget_model.dart';
import 'package:devity_sdk/core/models/padding_renderer_model.dart';
import 'package:devity_sdk/core/models/row_renderer_model.dart';
import 'package:devity_sdk/core/models/scrollable_renderer_model.dart';
import 'package:devity_sdk/core/models/style_model.dart';
import 'package:devity_sdk/core/models/text_field_widget_model.dart';
import 'package:devity_sdk/core/models/text_widget_model.dart';
// Placeholder for actual renderer models

/// Base class for all parsed components from the Spec JSON.
abstract class ComponentModel {
  ComponentModel({required this.type, this.id, this.style});

  /// Factory constructor to parse a component from JSON.
  /// This acts as a dispatcher to the appropriate subclass's fromJson factory.
  factory ComponentModel.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    final widgetType = json['widgetType'] as String?; // For widgets
    final rendererType = json['rendererType'] as String?; // For renderers

    // Dispatch based on 'type' first (Screen, Renderer, Widget)
    // Then, for 'Widget', dispatch based on 'widgetType'
    // For 'Renderer', dispatch based on 'rendererType'
    switch (type) {
      case 'Screen':
        // ScreenModel.fromJson should be called directly by DevitySpec.fromJson
        // If a Screen can be a child component (unlikely for general ComponentModel factory),
        // then import ScreenModel and call its fromJson.
        // import 'package:devity_sdk/core/models/screen_model.dart';
        // return ScreenModel.fromJson(json);
        throw UnimplementedError(
            'Screen parsing directly via ComponentModel.fromJson is not typical. DevitySpec handles screen parsing.');

      case 'Renderer':
        switch (rendererType) {
          case 'Column':
            return ColumnRendererModel.fromJson(json);
          case 'Row':
            return RowRendererModel.fromJson(json);
          case 'Padding':
            return PaddingRendererModel.fromJson(json);
          case 'Scrollable':
            return ScrollableRendererModel.fromJson(json);
          // Add cases for other renderer types
          default:
            print(
                "Error: Unknown rendererType '$rendererType' for component type '$type' in JSON: $json");
            throw FormatException(
                'Unknown rendererType: $rendererType for type Renderer.');
        }

      case 'Widget':
        // For type 'Widget', use 'widgetType' to determine the specific widget model
        switch (widgetType) {
          case 'Text':
            return TextWidgetModel.fromJson(json);
          case 'Button':
            return ButtonWidgetModel.fromJson(json);
          case 'TextField':
            return TextFieldWidgetModel.fromJson(json);
          case 'Image':
            return ImageWidgetModel.fromJson(json);
          // Add cases for other widget types
          default:
            print(
                "Error: Unknown widgetType '$widgetType' for component type '$type' in JSON: $json");
            throw FormatException(
                'Unknown widgetType: $widgetType for type Widget.');
        }

      default:
        print("Error: Unknown component type '$type' in JSON: $json");
        throw FormatException(
            'Unknown component type: $type. Ensure the type is correct and its parsing logic is implemented in ComponentModel.fromJson.');
    }
  }

  /// Unique identifier for the component within the spec.
  /// Might be null for components that don't need direct referencing.
  final String? id;

  /// The type of the component (e.g., Screen, Renderer, Widget, Action).
  final String type;

  final StyleModel? style;

  /// Serializes the component to JSON. Subclasses must implement this.
  Map<String, dynamic> toJson();
}
