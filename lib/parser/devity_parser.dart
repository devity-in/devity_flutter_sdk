import 'dart:convert';

import 'package:devity_sdk/core/core.dart';
import 'package:devity_sdk/core/models/action_model.dart';
import 'package:devity_sdk/core/models/column_renderer_model.dart';
import 'package:devity_sdk/core/models/component_model.dart';
import 'package:devity_sdk/core/models/renderer_model.dart';
import 'package:devity_sdk/core/models/rule_model.dart';
import 'package:devity_sdk/core/models/screen_model.dart';
import 'package:devity_sdk/core/models/spec_model.dart';
import 'package:devity_sdk/core/models/text_widget_model.dart';
import 'package:devity_sdk/core/models/widget_model.dart';
import 'package:devity_sdk/core/models/button_widget_model.dart';
import 'package:devity_sdk/core/models/set_state_action_model.dart';
import 'package:devity_sdk/core/models/navigate_action_model.dart';
import 'package:devity_sdk/core/models/show_alert_action_model.dart';
// We will define component parsers here for now, move later
// import 'package:devity_sdk/parser/layout_parser/layout_parser.dart';
// import 'package:devity_sdk/parser/widget_parser/widget_parser.dart';

/// Parses the complete Spec JSON into a [SpecModel].
SpecModel parseSpec(String jsonString) {
  // Cast the result of json.decode to the expected type
  final Map<String, dynamic> jsonMap =
      json.decode(jsonString) as Map<String, dynamic>;
  return parseSpecFromJsonMap(jsonMap);
}

/// Parses a Map representation of the Spec JSON into a [SpecModel].
SpecModel parseSpecFromJsonMap(Map<String, dynamic> json) {
  // TODO: Add robust error handling for missing/invalid fields
  return SpecModel(
    specVersion: json['specVersion'] as String? ?? '0.0.0',
    specId: json['specId'] as String? ?? 'unknown',
    version: json['version'] as int? ?? 0,
    createdAt: json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'] as String? ?? '') ??
            DateTime.now()
        : DateTime.now(),
    entryPoint: json['entryPoint'] as String? ?? '',
    globalData: json['globalData'] as Map<String, dynamic>?,
    screens: (json['screens'] as Map<String, dynamic>? ?? {}).map(
      (key, value) => MapEntry(key, parseScreen(value as Map<String, dynamic>)),
    ),
    actions: (json['actions'] as Map<String, dynamic>? ?? {}).map(
      (key, value) =>
          MapEntry(key, parseAction(key, value as Map<String, dynamic>)),
    ),
    rules: (json['rules'] as Map<String, dynamic>? ?? {}).map(
      (key, value) =>
          MapEntry(key, RuleModel.fromJson(key, value as Map<String, dynamic>)),
    ),
  );
}

/// Parses a Screen JSON object into a [ScreenModel].
ScreenModel parseScreen(Map<String, dynamic> json) {
  final bodyJson = json['body'] as Map<String, dynamic>?;
  if (bodyJson == null) {
    throw FormatException("Screen body is required and must be a Renderer.");
  }
  // Ensure the body is actually a renderer type
  if (bodyJson['type'] != 'Renderer') {
    throw FormatException(
        "Screen body component must have type 'Renderer'. Found: ${bodyJson['type']}");
  }

  return ScreenModel(
    id: json['id'] as String? ?? 'no_id',
    backgroundColor: json['backgroundColor'] as String?,
    // Directly parse the body as a Renderer
    body: parseRenderer(bodyJson),
    onLoadActions:
        (json['onLoadActions'] as List<dynamic>? ?? []).cast<String>(),
    persistentData: json['persistentData'] as Map<String, dynamic>?,
    // appBar: json['appBar'] != null ? parseRenderer(json['appBar']) : null, // Assuming appBar is also a Renderer
    // bottomNavBar: json['bottomNavBar'] != null ? parseRenderer(json['bottomNavBar']) : null, // Assuming bottomNavBar is also a Renderer
  );
}

/// Parses any component (Renderer or Widget) based on its 'type'.
ComponentModel parseComponent(Map<String, dynamic> json) {
  final type = json['type'] as String?;
  if (type == null) {
    throw FormatException("Component 'type' is required.");
  }

  switch (type) {
    case 'Renderer':
      return parseRenderer(json);
    case 'Widget':
      return parseWidget(json);
    default:
      // TODO: Improve logging/error handling
      print("ERROR: Unknown component type encountered: $type. JSON: $json");
      throw FormatException("Unknown component type: $type");
  }
}

/// Parses a Renderer JSON object into a [RendererModel].
RendererModel parseRenderer(Map<String, dynamic> json) {
  final rendererType = json['rendererType'] as String?;
  // Verify the component type is indeed 'Renderer' (redundant if called via parseComponent, but good practice)
  final type = json['type'] as String?;
  if (type != 'Renderer') {
    throw FormatException(
        "Expected component type 'Renderer', but found '$type'.");
  }
  if (rendererType == null) {
    throw FormatException("Renderer component missing 'rendererType'.");
  }

  final childrenList = (json['children'] as List<dynamic>? ?? []);
  final id = json['id'] as String?; // Renderers might not always need an ID
  final attributes = json['attributes'] as Map<String, dynamic>?;
  // TODO: Define and parse specific attributes for different renderers
  final style =
      json['style'] as Map<String, dynamic>?; // TODO: Implement Style parsing

  // Parse children recursively
  final List<ComponentModel> children = childrenList
      .map((childJson) => parseComponent(childJson as Map<String, dynamic>))
      .toList();

  switch (rendererType) {
    case 'Column':
      // Example: Extract Column-specific attributes if they existed
      // final mainAxisAlignment = attributes?['mainAxisAlignment'] as String?;
      return ColumnRendererModel(
        id: id,
        attributes: attributes,
        style: style,
        children: children, // Pass the parsed children models
      );
    // TODO: Add cases for 'Row', 'Stack', 'Scrollable', 'Padding' etc.
    default:
      // TODO: Improve logging/error handling
      print("WARN: Unknown renderer type: $rendererType. JSON: $json");
      // Return a basic fallback or throw error? Throwing for now.
      throw FormatException("Unknown renderer type: $rendererType");
  }
}

/// Parses a Widget JSON object into a [WidgetModel].
WidgetModel parseWidget(Map<String, dynamic> json) {
  final widgetType = json['widgetType'] as String?;
  final type = json['type'] as String?;
  if (type != 'Widget') {
    throw FormatException(
        "Expected component type 'Widget', but found '$type'.");
  }
  if (widgetType == null) {
    throw FormatException("Widget component missing 'widgetType'.");
  }

  final id = json['id'] as String?;
  final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
  final style = json['style'] as Map<String, dynamic>?;
  final onClickActionIds =
      (json['onClickActionIds'] as List<dynamic>? ?? []).cast<String>();
  // Parse onValueChangedActionIds from the top-level widget JSON
  final onValueChangedActionIds =
      (json['onValueChangedActionIds'] as List<dynamic>? ?? []).cast<String>();

  if (id == null) {
    throw FormatException(
        "Widget ID ('id') is required. WidgetType: $widgetType");
  }

  switch (widgetType) {
    case 'Text':
      // Extract Text-specific attributes
      final text = attributes['text'] as String?;
      if (text == null) {
        print(
            "WARN: Text widget '$id' missing 'text' attribute. Defaulting to empty string.");
      }
      final fontSize = (attributes['fontSize'] as num?)?.toDouble();
      final fontWeight =
          attributes['fontWeight'] as String?; // TODO: Map to FontWeight enum?
      final color = attributes['color'] as String?; // TODO: Map to Color type?

      return TextWidgetModel(
        id: id,
        text: text ?? '', // Provide default value
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        style: style,
        onClickActionIds: onClickActionIds,
        // Text doesn't have onValueChanged, but keep field in base model?
      );

    case 'Button':
      // Extract Button-specific attributes
      final text = attributes['text'] as String?;
      if (text == null) {
        print(
            "WARN: Button widget '$id' missing 'text' attribute. Defaulting to 'Button'.");
      }

      return ButtonWidgetModel(
        id: id,
        text: text ?? 'Button', // Provide default value
        style: style,
        onClickActionIds: onClickActionIds,
      );

    case 'TextField':
      // Extract TextField-specific attributes
      final initialValue = attributes['initialValue'] as String?;
      final label = attributes['label'] as String?;
      final placeholder = attributes['placeholder'] as String?;

      return TextFieldWidgetModel(
        id: id,
        initialValue: initialValue,
        label: label,
        placeholder: placeholder,
        style: style,
        onValueChangedActionIds: onValueChangedActionIds,
        rawAttributes: attributes, // Pass original attributes if needed by base
      );

    // TODO: Add cases for 'Image'
    default:
      // TODO: Improve logging/error handling
      print("WARN: Unknown widget type: $widgetType. JSON: $json");
      throw FormatException("Unknown widget type: $widgetType");
  }
}

/// Parses an Action JSON object into an [ActionModel].
ActionModel parseAction(String id, Map<String, dynamic> json) {
  final actionType = json['actionType'] as String?;
  if (actionType == null) {
    throw FormatException("Action definition missing 'actionType' for id: $id");
  }

  // Changed 'params' to 'attributes' to match model definitions
  final attributes = json['attributes'] as Map<String, dynamic>? ?? {};

  switch (actionType) {
    case 'setState':
      // 'attributes' for setState should contain the 'updates' map
      final updates = attributes['updates'] as Map<String, dynamic>?;
      if (updates == null) {
        throw FormatException(
            "SetState action '$id' missing 'updates' in attributes.");
      }
      return SetStateActionModel(
        id: id,
        updates: updates,
      );

    case 'Navigate':
      final screenId = attributes['screenId'] as String?;
      if (screenId == null) {
        throw FormatException(
            "Navigate action '$id' missing 'screenId' in attributes.");
      }
      return NavigateActionModel(
        id: id,
        screenId: screenId,
      );

    case 'ShowAlert':
      final title = attributes['title'] as String?;
      final message = attributes['message'] as String?;
      if (title == null || message == null) {
        throw FormatException(
            "ShowAlert action '$id' missing 'title' or 'message' in attributes.");
      }
      return ShowAlertActionModel(
        id: id,
        title: title,
        message: message,
      );

    // TODO: Add cases for other action types ('apiCall', etc.)

    default:
      print("WARN: Unknown action type: $actionType for id: $id. JSON: $json");
      // Return a generic ActionModel or throw? Throwing for now.
      throw FormatException("Unknown action type: $actionType");
    // Or return generic:
    // return ActionModel(id: id, actionType: actionType, params: params);
  }
}

// TODO: Implement Rule parsing (similar structure to Action parsing)
// RuleModel parseRule(String id, Map<String, dynamic> json) { ... }
