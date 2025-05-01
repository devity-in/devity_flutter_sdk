import 'package:devity_sdk/core/core.dart';
import 'package:flutter/material.dart';

// TODO: Define a state management approach later (Provider, Riverpod, etc.)
// For now, a simple StatefulWidget to hold the spec and trigger rendering.

/// The main widget that renders a Devity screen based on a [ScreenModel].
/// It handles fetching/receiving the screen model and initiating the build process.
class DevityScreenRenderer extends StatefulWidget {
  // Initially, we might pass the model directly.
  // Later, this could take a specId/screenId and handle fetching.
  final ScreenModel screenModel;

  const DevityScreenRenderer({super.key, required this.screenModel});

  @override
  State<DevityScreenRenderer> createState() => _DevityScreenRendererState();
}

class _DevityScreenRendererState extends State<DevityScreenRenderer> {
  @override
  Widget build(BuildContext context) {
    // Basic Scaffold wrapper for the screen content
    // TODO: Add AppBar/BottomNavBar rendering based on ScreenModel properties
    return Scaffold(
      backgroundColor: _parseColor(widget.screenModel.backgroundColor),
      body: buildComponent(context, widget.screenModel.body),
    );
  }
}

/// Recursively builds Flutter widgets from Devity component models.
Widget buildComponent(BuildContext context, ComponentModel model) {
  if (model is RendererModel) {
    return buildRenderer(context, model);
  } else if (model is WidgetModel) {
    return buildWidget(context, model);
  } else {
    // Handle unknown component type - return placeholder or throw error
    print("Error: Unknown ComponentModel type: ${model.runtimeType}");
    return const SizedBox(
        child: Text("Error: Unknown Component",
            style: TextStyle(color: Colors.red)));
  }
}

/// Builds Flutter widgets specifically for Devity Renderer models.
Widget buildRenderer(BuildContext context, RendererModel model) {
  // TODO: Apply common renderer properties (style, attributes) if needed

  switch (model) {
    case ColumnRendererModel():
      // Recursively build children
      final childrenWidgets = model.children
          .map((child) => buildComponent(context, child))
          .toList();
      // TODO: Apply Column-specific attributes (mainAxisAlignment, crossAxisAlignment, etc.)
      return Column(
        // Default alignment for now
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: childrenWidgets,
      );
    // TODO: Add cases for Row, Stack, etc.
    default:
      print("Error: Unknown RendererModel type: ${model.runtimeType}");
      return const SizedBox(
          child: Text("Error: Unknown Renderer",
              style: TextStyle(color: Colors.red)));
  }
}

/// Builds Flutter widgets specifically for Devity Widget models.
Widget buildWidget(BuildContext context, WidgetModel model) {
  // TODO: Apply common widget properties (style, onClick actions)

  switch (model) {
    case TextWidgetModel():
      // TODO: Implement more robust style/attribute mapping
      return Text(
        model.text,
        // Basic style mapping
        style: TextStyle(
          fontSize: model.fontSize,
          fontWeight: _parseFontWeight(model.fontWeight),
          color: _parseColor(model.color),
          // TODO: Apply styles from model.style map
        ),
      );
    // TODO: Add cases for Button, Image, TextField, etc.
    default:
      print("Error: Unknown WidgetModel type: ${model.runtimeType}");
      return const SizedBox(
          child: Text("Error: Unknown Widget",
              style: TextStyle(color: Colors.red)));
  }
}

// --- Helper Functions ---

// Basic color parser (assumes hex format like "#RRGGBB" or "#AARRGGBB")
// TODO: Enhance error handling and support for named colors
Color? _parseColor(String? hexColor) {
  if (hexColor == null || !hexColor.startsWith('#')) return null;
  try {
    final buffer = StringBuffer();
    if (hexColor.length == 7) buffer.write('ff'); // Add alpha if missing
    buffer.write(hexColor.substring(1));
    return Color(int.parse(buffer.toString(), radix: 16));
  } catch (e) {
    print("Error parsing color: '$hexColor'. Error: $e");
    return null; // Return null or a default color on error
  }
}

// Basic FontWeight parser
// TODO: Enhance to support more weights or numerical values
FontWeight? _parseFontWeight(String? weight) {
  switch (weight?.toLowerCase()) {
    case 'bold':
      return FontWeight.bold;
    case 'normal':
      return FontWeight.normal;
    // Add other common weights (e.g., 'light', 'w100'-'w900')
    default:
      return null; // Default to normal or null
  }
}

// TODO: Add helper for Style map parsing
// TODO: Add helper for Action execution binding
