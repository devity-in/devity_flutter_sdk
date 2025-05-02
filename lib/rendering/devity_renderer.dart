import 'package:devity_sdk/core/core.dart';
// Import Bloc and State/Event files
import 'package:devity_sdk/state/devity_screen_bloc.dart';
import 'package:devity_sdk/state/devity_screen_event.dart';
import 'package:devity_sdk/state/devity_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Define a state management approach later (Provider, Riverpod, etc.) -> Using Bloc now
// For now, a simple StatefulWidget to hold the spec and trigger rendering.

/// The main widget that renders a Devity screen based on a [ScreenModel].
/// It sets up the [DevityScreenBloc] and initiates the build process.
class DevityScreenRenderer extends StatelessWidget {
  // Changed to StatelessWidget
  final ScreenModel screenModel;

  const DevityScreenRenderer({super.key, required this.screenModel});

  @override
  Widget build(BuildContext context) {
    // Provide the DevityScreenBloc to the widget subtree
    return BlocProvider(
      create: (context) => DevityScreenBloc()
        // Initialize the Bloc state with persistent data from the screen model
        ..add(DevityScreenInitialize(initialData: screenModel.persistentData)),
      child: Scaffold(
        // TODO: Add AppBar/BottomNavBar rendering based on ScreenModel properties
        backgroundColor: _parseColor(screenModel.backgroundColor),
        // Pass the ScreenModel down if needed by buildComponent,
        // or access data via BlocProvider.of<DevityScreenBloc>(context).state
        body: buildComponent(context, screenModel.body),
      ),
    );
  }
}

/// Recursively builds Flutter widgets from Devity component models.
/// Widgets needing state should use BlocProvider.of<DevityScreenBloc>(context)
Widget buildComponent(BuildContext context, ComponentModel model) {
  // Access state if needed: final screenState = context.watch<DevityScreenBloc>().state;
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
