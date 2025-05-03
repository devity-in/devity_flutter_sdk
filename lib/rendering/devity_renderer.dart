import 'package:devity_sdk/core/core.dart';
import 'package:devity_sdk/core/models/padding_renderer_model.dart'; // Import Padding model
import 'package:devity_sdk/core/models/row_renderer_model.dart'; // Import Row model
import 'package:devity_sdk/core/models/scrollable_renderer_model.dart'; // Import Scrollable model
import 'package:devity_sdk/core/models/style_model.dart'; // Import Style model
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
  Widget builtRenderer;

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
      builtRenderer = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: childrenWidgets,
      );
// Added break
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
      builtRenderer = Row(
        children: childrenWidgets,
      );
// Added break
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
      // NOTE: Style padding is handled by _applyStyles below.
      // The Padding specified by PaddingRendererModel takes precedence as it's more specific.
      builtRenderer = Padding(
        padding: model.padding.edgeInsets,
        child: childWidget,
      );
      // We do NOT apply style padding here again, _applyStyles handles background etc.
      // but the Padding widget itself doesn't take style.
      return _applyStyles(
          builtRenderer, model.style); // Apply other styles like background
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
      builtRenderer = SingleChildScrollView(
        scrollDirection: model.scrollDirection, // Use direction from model
        child: childWidget,
      );
// Added break
    // TODO: Add cases for Stack, etc.
    default:
      print('Error: Unknown RendererModel type: ${model.runtimeType}');
      builtRenderer = const SizedBox(
        child: Text(
          'Error: Unknown Renderer',
          style: TextStyle(color: Colors.red),
        ),
      );
// Added break
  }

  // Apply common styles (padding, background) to the built renderer
  return _applyStyles(builtRenderer, model.style);
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

  Widget builtWidget;

  switch (model) {
    case TextWidgetModel():
      // Evaluate potential binding in text attribute
      final evaluatedText = ExpressionService.evaluate(model.text, screenState);

      // Determine color: Style > Attribute > Default
      final textColor = model.style?.textColor ?? _parseColor(model.color);

      // TODO: Implement more robust style/attribute mapping (evaluate these too?)
      builtWidget = Text(
        evaluatedText, // Use evaluated text
        // Basic style mapping
        style: TextStyle(
          fontSize: model.fontSize,
          fontWeight: _parseFontWeight(model.fontWeight),
          color: textColor, // Use prioritized color
          // TODO: Apply other styles from model.style map (fontFamily etc.)
        ),
      );
// Added break
    case ButtonWidgetModel():
      // Evaluate potential binding in button text
      final evaluatedButtonText =
          ExpressionService.evaluate(model.text, screenState);

      // Handle enabled state for onPressed
      final onPressedCallback = model.enabled
          ? () {
              print(
                "Button '${model.id}' pressed. Actions: ${model.onClickActionIds}",
              );
              actionHandler.executeActions(
                context,
                specModel, // Pass the spec model down
                model.onClickActionIds,
              );
            }
          : null; // Set to null if button is not enabled

      // TODO: Apply Button-specific styles (button color, text color, etc.) from style
      builtWidget = ElevatedButton(
        onPressed: onPressedCallback,
        child: Text(evaluatedButtonText), // Use evaluated text
      );
// Added break
    case TextFieldWidgetModel():
      // TODO: Handle initial value binding?
      // TODO: Apply style props (background, text color/style etc.)
      builtWidget = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextField(
          decoration: InputDecoration(
            labelText: model.label, // Use label
            hintText: model.placeholder, // Use placeholder
            border: const OutlineInputBorder(), // Basic border
          ),
          keyboardType:
              _parseTextInputType(model.keyboardType), // Parse keyboard type
          obscureText: model.obscureText,
          onChanged: (newValue) {
            print(
              "TextField '${model.id}' changed: $newValue. Actions: ${model.onValueChangedActionIds}",
            );
            actionHandler.executeActions(
              context,
              specModel,
              model.onValueChangedActionIds,
              eventPayload: {'value': newValue},
            );
          },
        ),
      );
// Added break
    // TODO: Add cases for 'Image'
    default:
      print('Error: Unknown WidgetModel type: ${model.runtimeType}');
      builtWidget = const SizedBox(
        child: Text(
          'Error: Unknown Widget',
          style: TextStyle(color: Colors.red),
        ),
      );
// Added break
  }

  // Apply common styles (padding, background) to the built widget
  return _applyStyles(builtWidget, model.style);
}

/// Helper function to wrap a widget with common style properties (Padding, BackgroundColor).
Widget _applyStyles(Widget child, StyleModel? style) {
  if (style == null) {
    return child; // No styles to apply
  }

  var styledChild = child;

  // Apply Padding from style, if specified
  if (style.padding != null) {
    // Note: This padding might wrap a PaddingRendererModel, applying padding twice.
    // Consider adding logic here or in the PaddingRendererModel case to prevent double padding.
    styledChild = Padding(
      padding: style.padding!.edgeInsets,
      child: styledChild,
    );
  }

  // Apply BackgroundColor from style, if specified
  if (style.backgroundColor != null) {
    styledChild = Container(
      color: style.backgroundColor,
      child: styledChild,
    );
  }

  return styledChild;
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

/// Basic TextInputType parser
TextInputType? _parseTextInputType(String? type) {
  switch (type?.toLowerCase()) {
    case 'text':
      return TextInputType.text;
    case 'number':
      return TextInputType.number;
    case 'email':
      return TextInputType.emailAddress;
    case 'phone':
      return TextInputType.phone;
    case 'url':
      return TextInputType.url;
    // Add others as needed (datetime, multiline, etc.)
    default:
      return null; // Default
  }
}

// TODO: Add helper for Action execution binding
