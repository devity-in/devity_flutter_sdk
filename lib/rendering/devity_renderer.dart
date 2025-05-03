import 'package:devity_sdk/core/core.dart';
import 'package:devity_sdk/core/models/padding_renderer_model.dart'; // Import Padding model
import 'package:devity_sdk/core/models/row_renderer_model.dart'; // Import Row model
import 'package:devity_sdk/core/models/scrollable_renderer_model.dart'; // Import Scrollable model
// Import Action Handler and SpecModel
import 'package:devity_sdk/services/action_handler.dart';
import 'package:devity_sdk/services/expression_service.dart'; // Import ExpressionService
// Import Bloc and State/Event files
import 'package:devity_sdk/state/devity_screen_bloc.dart';
import 'package:devity_sdk/state/devity_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Define a state management approach later (Provider, Riverpod, etc.) -> Using Bloc now
// For now, a simple StatefulWidget to hold the spec and trigger rendering.

/// The main widget that renders a Devity screen based on a [ScreenModel].
/// It sets up the [DevityScreenBloc] and initiates the build process.
class DevityScreenRenderer extends StatelessWidget {
  // Add navigationHandler

  const DevityScreenRenderer({
    required this.screenModel,
    super.key,
    this.specModel,
    this.navigationHandler, // Add to constructor
  });
  // Changed to StatelessWidget
  final ScreenModel screenModel;
  final SpecModel? specModel;
  final NavigationHandler? navigationHandler;

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
        // Pass specModel and navigationHandler down
        body: buildComponent(
          context,
          screenModel.body,
          specModel,
          navigationHandler,
        ),
      ),
    );
  }
}

/// Recursively builds Flutter widgets from Devity component models.
/// Widgets needing state should use BlocProvider.of<DevityScreenBloc>(context)
Widget buildComponent(
  BuildContext context,
  ComponentModel model,
  SpecModel? specModel,
  NavigationHandler? navigationHandler, // Add handler
) {
  // Access state if needed: final screenState = context.watch<DevityScreenBloc>().state;
  if (model is RendererModel) {
    return buildRenderer(
      context,
      model,
      specModel,
      navigationHandler,
    ); // Pass down
  } else if (model is WidgetModel) {
    return buildWidget(
      context,
      model,
      specModel,
      navigationHandler,
    ); // Pass down
  } else {
    // Handle unknown component type - return placeholder or throw error
    print('Error: Unknown ComponentModel type: ${model.runtimeType}');
    return const SizedBox(
      child: Text(
        'Error: Unknown Component',
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}

/// Builds Flutter widgets specifically for Devity Renderer models.
Widget buildRenderer(
  BuildContext context,
  RendererModel model,
  SpecModel? specModel,
  NavigationHandler? navigationHandler, // Add handler
) {
  // TODO: Apply common renderer properties (style, attributes) if needed

  switch (model) {
    case ColumnRendererModel():
      // Recursively build children
      final childrenWidgets = model.children
          .map(
            (child) => buildComponent(
              context,
              child,
              specModel,
              navigationHandler,
            ),
          ) // Pass down
          .toList();
      // TODO: Apply Column-specific attributes (mainAxisAlignment, crossAxisAlignment, etc.)
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: childrenWidgets,
      );
    // Add case for RowRendererModel
    case RowRendererModel():
      // Recursively build children
      final childrenWidgets = model.children
          .map(
            (child) => buildComponent(
              context,
              child,
              specModel,
              navigationHandler,
            ),
          ) // Pass down
          .toList();
      // TODO: Apply Row-specific attributes (mainAxisAlignment, crossAxisAlignment, etc.) from model.attributes
      return Row(
        children: childrenWidgets,
      );
    // Add case for PaddingRendererModel
    case PaddingRendererModel():
      // Padding model ensures it has exactly one child
      final childWidget = buildComponent(
        context,
        model.child, // Use the single child
        specModel,
        navigationHandler,
      );
      // Apply padding using the parsed PaddingValue
      return Padding(
        padding: model.padding.edgeInsets,
        child: childWidget,
      );
    // Add case for ScrollableRendererModel
    case ScrollableRendererModel():
      // Scrollable model ensures it has exactly one child
      final childWidget = buildComponent(
        context,
        model.child, // Use the single child
        specModel,
        navigationHandler,
      );
      // Wrap the child in a SingleChildScrollView
      return SingleChildScrollView(
        scrollDirection: model.scrollDirection, // Use direction from model
        child: childWidget,
      );
    // TODO: Add cases for Stack, etc.
    default:
      print('Error: Unknown RendererModel type: ${model.runtimeType}');
      return const SizedBox(
        child: Text(
          'Error: Unknown Renderer',
          style: TextStyle(color: Colors.red),
        ),
      );
  }
}

/// Builds Flutter widgets specifically for Devity Widget models.
Widget buildWidget(
  BuildContext context,
  WidgetModel model,
  SpecModel? specModel,
  NavigationHandler? navigationHandler, // Add handler
) {
  // Instantiate ActionHandler here, passing the handler
  final actionHandler = ActionHandler(navigationHandler: navigationHandler);

  // Get current state from Bloc for potential bindings
  // Use context.watch for reactivity
  final screenState = context.watch<DevityScreenBloc>().state.data;

  // TODO: Apply common widget properties (style, onClick actions)

  switch (model) {
    case TextWidgetModel():
      // Evaluate potential binding in text attribute
      final evaluatedText = ExpressionService.evaluate(model.text, screenState);

      // TODO: Implement more robust style/attribute mapping (evaluate these too?)
      return Text(
        evaluatedText, // Use evaluated text
        // Basic style mapping
        style: TextStyle(
          fontSize: model.fontSize,
          fontWeight: _parseFontWeight(model.fontWeight),
          color: _parseColor(model.color),
          // TODO: Apply styles from model.style map
        ),
      );
    case ButtonWidgetModel():
      // Evaluate potential binding in button text
      final evaluatedButtonText =
          ExpressionService.evaluate(model.text, screenState);

      // TODO: Apply Button-specific styles (button color, text color, etc.)
      return ElevatedButton(
        onPressed: () {
          // M2 Commit 12: Trigger Action Handler
          print(
            "Button '${model.id}' pressed. Actions: ${model.onClickActionIds}",
          );
          actionHandler.executeActions(
            context,
            specModel, // Pass the spec model down
            model.onClickActionIds,
          );
        },
        child: Text(evaluatedButtonText), // Use evaluated text
      );
    case TextFieldWidgetModel():
      // TODO: Handle initial value binding?
      // final initialValue = ExpressionService.evaluate(model.initialValue, screenState);
      // Need TextEditingController for initial value and updates
      // Potential issue: Controller recreated on every build if not managed.
      // For now, ignore initialValue binding and focus on onChanged.
      return Padding(
        // Add padding for visual spacing
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextField(
          // controller: // See TODO above
          decoration: InputDecoration(
            labelText: model.label, // Use label
            hintText: model.placeholder, // Use placeholder
            border: const OutlineInputBorder(), // Basic border
          ),
          onChanged: (newValue) {
            // M4 Commit 5: Trigger actions on value change
            print(
              "TextField '${model.id}' changed: $newValue. Actions: ${model.onValueChangedActionIds}",
            );
            // Pass the new value in the payload
            actionHandler.executeActions(
              context,
              specModel,
              model.onValueChangedActionIds,
              eventPayload: {'value': newValue},
            );
          },
        ),
      );
    // TODO: Add cases for 'Image'
    default:
      print('Error: Unknown WidgetModel type: ${model.runtimeType}');
      return const SizedBox(
        child: Text(
          'Error: Unknown Widget',
          style: TextStyle(color: Colors.red),
        ),
      );
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
