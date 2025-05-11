import 'package:devity_sdk/core/models/button_widget_model.dart';
import 'package:devity_sdk/core/models/column_renderer_model.dart';
import 'package:devity_sdk/core/models/image_widget_model.dart';
import 'package:devity_sdk/core/models/padding_renderer_model.dart';
import 'package:devity_sdk/core/models/renderer_model.dart';
import 'package:devity_sdk/core/models/row_renderer_model.dart';
import 'package:devity_sdk/core/models/screen_model.dart';
import 'package:devity_sdk/core/models/scrollable_renderer_model.dart';
import 'package:devity_sdk/core/models/style_model.dart';
import 'package:devity_sdk/core/models/text_field_widget_model.dart';
import 'package:devity_sdk/core/models/text_widget_model.dart';
import 'package:devity_sdk/core/models/widget_model.dart';
import 'package:devity_sdk/models/spec_model.dart'; // Provides DevitySpec
import 'package:devity_sdk/providers/action_service_provider.dart';
import 'package:devity_sdk/services/expression_service.dart';
import 'package:devity_sdk/state/devity_screen_bloc.dart';
import 'package:devity_sdk/state/devity_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: Define a state management approach later (Provider, Riverpod, etc.) -> Using Bloc now
// For now, a simple StatefulWidget to hold the spec and trigger rendering.

/// The main widget that renders a Devity screen based on a [ScreenModel].
/// It sets up the [DevityScreenBloc] and initiates the build process.
class DevityScreenRenderer extends StatefulWidget {
  const DevityScreenRenderer({
    required this.screenModel, // Expects new ScreenModel from models/spec_model.dart
    super.key,
    this.specModel, // Expects DevitySpec from models/spec_model.dart
    this.onElementTap, // Callback for when an element is tapped in the preview
    this.selectedElementId, // ID of the currently selected element for highlighting
  });
  final ScreenModel
      screenModel; // Uses new ScreenModel from models/spec_model.dart
  final DevitySpec? specModel;
  final void Function(String? elementId)? onElementTap;
  final String? selectedElementId;

  @override
  State<DevityScreenRenderer> createState() => _DevityScreenRendererState();
}

class _DevityScreenRendererState extends State<DevityScreenRenderer> {
  @override
  void initState() {
    super.initState();
    final actionService = ActionServiceProvider.of(context);
    if (actionService != null &&
        widget.screenModel.onLoadActions?.isNotEmpty == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          actionService.executeActionsByIds(
            widget.screenModel.onLoadActions!,
            context,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // If onElementTap is provided, assume we are in an editor context
    // and taps should primarily trigger selection.
    // If not, normal interaction (like button presses) should work as usual.
    // Highlighting is controlled by selectedElementId.

    var bodyContent = widget.screenModel.body != null
        ? buildComponent(
            context,
            widget.screenModel.body,
            widget.specModel,
            widget.onElementTap, // Pass down for selection
            widget.selectedElementId, // Pass down for highlighting
          )
        : const Center(
            child: Text(
              'Screen body is not defined',
              style: TextStyle(color: Colors.orange),
            ),
          );

    // If onElementTap is defined (editor mode), wrap the entire screen body
    // with a GestureDetector to allow de-selecting by tapping the background.
    if (widget.onElementTap != null) {
      bodyContent = GestureDetector(
        onTap: () {
          widget.onElementTap!(null); // Tap on background clears selection
        },
        behavior: HitTestBehavior.translucent,
        child: bodyContent, // Ensure it catches taps on empty areas
      );
    }

    return BlocProvider(
      create: (context) => DevityScreenBloc()
        ..add(
          DevityScreenInitialize(
            initialData: widget.screenModel.persistentData,
          ),
        ),
      child: Scaffold(
        backgroundColor: _parseColor(widget.screenModel.backgroundColor),
        body: bodyContent,
      ),
    );
  }
}

/// Recursively builds Flutter widgets from Devity component models.
/// Widgets needing state should use BlocProvider.of<DevityScreenBloc>(context)
Widget buildComponent(
  BuildContext context,
  dynamic
      model, // Changed ComponentModel to dynamic for now to handle core types
  DevitySpec? specModel,
  void Function(String? elementId)? onElementTap,
  String? selectedElementId,
) {
  Widget builtContent;
  String? currentElementId;

  if (model is RendererModel) {
    currentElementId = model.id;
    builtContent = buildRenderer(
      context,
      model,
      specModel,
      onElementTap,
      selectedElementId,
    );
  } else if (model is WidgetModel) {
    currentElementId = model.id;
    builtContent = buildWidget(
      context,
      model,
      specModel,
      onElementTap,
      selectedElementId,
    );
  } else if (model is Map<String, dynamic> &&
      model.containsKey('message') &&
      model['message'] == 'dummy') {
    // Dummy components usually don't have IDs or selection
    return Text("Dummy Component: ${model['id']} - ${model['type']}");
  } else {
    print(
      'Error: Unknown or unhandled model type in buildComponent: ${model.runtimeType}',
    );
    return const SizedBox(
      child: Text(
        'Error: Unknown Component Type',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }

  // Apply highlight and tap if onElementTap is provided (editor mode)
  // Components might not have an ID (e.g. a generic Renderer without one specified in spec)
  // Only make selectable if it has an ID.
  if (currentElementId != null && onElementTap != null) {
    return _applySelectionHighlight(
        builtContent, currentElementId, selectedElementId, onElementTap);
  }
  return builtContent;
}

/// Builds Flutter widgets specifically for Devity Renderer models.
Widget buildRenderer(
  BuildContext context,
  RendererModel
      model, // Assumes RendererModel is compatible with ComponentModel used in buildComponent
  DevitySpec? specModel,
  void Function(String? elementId)? onElementTap,
  String? selectedElementId,
) {
  Widget builtRenderer;
  switch (model) {
    case ColumnRendererModel():
      final childrenWidgets = model.children
          .map(
            (child) => buildComponent(
              context,
              child,
              specModel,
              onElementTap,
              selectedElementId,
            ),
          )
          .toList();
      builtRenderer = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: childrenWidgets,
      );
// Ensure breaks are present
    case RowRendererModel():
      final childrenWidgets = model.children
          .map(
            (child) => buildComponent(
              context,
              child,
              specModel,
              onElementTap,
              selectedElementId,
            ),
          )
          .toList();
      builtRenderer = Row(
        children: childrenWidgets,
      );
    case PaddingRendererModel():
      final childWidget = buildComponent(
        context,
        model.child,
        specModel,
        onElementTap,
        selectedElementId,
      );
      builtRenderer = Padding(
        padding: model.padding.edgeInsets,
        child: childWidget,
      );
      return _applyStyles(
        builtRenderer,
        model.style,
      ); // Padding already handles child, apply style to Padding itself
    case ScrollableRendererModel():
      final childWidget = buildComponent(
        context,
        model.child,
        specModel,
        onElementTap,
        selectedElementId,
      );
      builtRenderer = SingleChildScrollView(
        scrollDirection: model.scrollDirection,
        child: childWidget,
      );
    default:
      print('Error: Unknown RendererModel type: ${model.runtimeType}');
      builtRenderer = const SizedBox(
        child: Text(
          'Error: Unknown Renderer',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
  }
  return _applyStyles(builtRenderer, model.style);
}

/// Builds Flutter widgets specifically for Devity Widget models.
Widget buildWidget(
  BuildContext context,
  WidgetModel model, // Assumes WidgetModel is compatible with ComponentModel
  DevitySpec? specModel,
  void Function(String? elementId)? onElementTap,
  String? selectedElementId,
) {
  final screenState = context.watch<DevityScreenBloc>().state.data;
  Widget builtWidgetContent; // Content before selection wrapper

  switch (model) {
    case TextWidgetModel():
      final evaluatedText = ExpressionService.evaluate(model.text, screenState);
      final textColor = model.style?.textColor ?? _parseColor(model.color);
      builtWidgetContent = Text(
        evaluatedText,
        style: TextStyle(
          fontSize: model.fontSize,
          fontWeight: _parseFontWeight(model.fontWeight),
          color: textColor,
        ),
        textAlign: _parseTextAlign(model.textAlign),
      );
    case ButtonWidgetModel():
      final evaluatedButtonText =
          ExpressionService.evaluate(model.text, screenState);
      final actionService = ActionServiceProvider.of(context);

      var onPressedEffective = model.enabled && actionService != null
          ? () {
              if (onElementTap == null) {
                // Only execute actions if not in editor selection mode for this button
                print(
                  "Button '${model.id}' pressed. Actions: ${model.onClickActionIds}",
                );
                if (model.onClickActionIds?.isNotEmpty == true) {
                  actionService.executeActionsByIds(
                    model.onClickActionIds!,
                    context,
                  );
                }
              } else {
                // In editor mode, tap is handled by GestureDetector from _applySelectionHighlight
                // or the one in buildComponent. If onElementTap is not null, we assume selection tap.
                // However, if a button is selected, its own actions should ideally still be testable?
                // This is a UX question. For now, primary tap selects in editor.
                // To test action: could be a secondary tap, or a button in attribute editor.
              }
            }
          : null;

      // If in editor selection mode, the outer GestureDetector handles selection tap.
      // The button's own onPressed should be disabled or modified if onElementTap is present
      // to prevent actions from firing when trying to select the button for editing.
      // However, we still want the button to look enabled if model.enabled is true.
      if (onElementTap != null) {
        onPressedEffective =
            null; // Disable button action when in selection mode for preview
      }

      builtWidgetContent = ElevatedButton(
        onPressed: onPressedEffective,
        child: Text(evaluatedButtonText),
        // TODO: Apply button specific styles (color, shape) from model.style or direct properties
      );
    case TextFieldWidgetModel():
      final evaluatedPlaceholder =
          ExpressionService.evaluate(model.placeholder, screenState);
      // TODO: Handle initial value binding and live value updates if needed for state.
      builtWidgetContent = TextField(
        decoration: InputDecoration(hintText: evaluatedPlaceholder),
        keyboardType: _parseKeyboardType(model.keyboardType),
        obscureText: model.obscureText,
        onChanged: (newValue) {
          print(
            "TextField '${model.id}' changed: $newValue. Actions: ${model.onValueChangedActionIds}",
          );
          // Temporarily comment out or adapt this part as ActionHandler might expect old SpecModel
          // For M3, onValueChangedActionIds is secondary to onClick and onLoad.
          /*
          if (model.onValueChangedActionIds?.isNotEmpty == true) {
            final actionHandler = ActionHandler(navigationHandler: navigationHandler); // Old handler
            actionHandler.executeActions(
              context,
              specModel, // This is DevitySpec?, ActionHandler might expect SpecModel?
              model.onValueChangedActionIds!,
            );
          }
          */
        },
      );
    case ImageWidgetModel():
      // TODO: Placeholder, implement image loading (network, asset)
      builtWidgetContent = model.url != null && model.url!.isNotEmpty
          ? Image.network(model.url!,
              fit: _parseBoxFit(model.fit),
              errorBuilder: (ctx, err, st) =>
                  const Icon(Icons.broken_image, color: Colors.grey, size: 48))
          : const Icon(Icons.image_not_supported, color: Colors.grey, size: 48);
      if (model.width != null || model.height != null) {
        builtWidgetContent = SizedBox(
          width: model.width,
          height: model.height,
          child: builtWidgetContent,
        );
      }
    default:
      print('Error: Unknown WidgetModel type: ${model.runtimeType}');
      builtWidgetContent = const SizedBox(
        child: Text(
          'Error: Unknown Widget',
          style: TextStyle(color: Colors.red),
        ),
      );
  }

  // Apply general styles from model.style AFTER specific widget styling
  // The selection highlight is applied by the buildComponent wrapper if model.id exists.
  return _applyStyles(builtWidgetContent, model.style);
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

Widget _applySelectionHighlight(
  Widget child,
  String? elementId,
  String? selectedElementId,
  void Function(String? elementId)? onElementTap,
) {
  if (elementId == null || onElementTap == null) return child;

  final isSelected = elementId == selectedElementId;
  return GestureDetector(
    onTap: () {
      // print('Tapped on element: $elementId');
      onElementTap(elementId);
    },
    behavior: HitTestBehavior.opaque, // Capture taps on the widget area itself
    child: Container(
      decoration: BoxDecoration(
        border: isSelected ? Border.all(color: Colors.blue, width: 2) : null,
        // borderRadius: isSelected ? BorderRadius.circular(4) : null,
      ),
      // Ensure minimum tap area for very small elements if necessary
      // constraints: BoxConstraints(minWidth: 10, minHeight: 10),
      child: child,
    ),
  );
}

// --- Helper Functions ---

// Basic color parser (assumes hex format like "#RRGGBB" or "#AARRGGBB")
// TODO: Enhance error handling and support for named colors
Color? _parseColor(String? colorString) {
  if (colorString == null || colorString.isEmpty) return null;
  if (colorString.startsWith('#')) {
    try {
      var hexColor = colorString.substring(1);
      if (hexColor.length == 6) {
        hexColor = 'FF$hexColor';
      }
      if (hexColor.length == 8) {
        return Color(int.parse('0x$hexColor'));
      }
    } catch (e) {
      print('Error parsing color: $colorString, $e');
      return null;
    }
  }
  return null;
}

// Basic FontWeight parser
// TODO: Enhance to support more weights or numerical values
FontWeight? _parseFontWeight(String? fontWeightString) {
  if (fontWeightString == null) return null;
  switch (fontWeightString.toLowerCase()) {
    case 'bold':
      return FontWeight.bold;
    case 'normal':
      return FontWeight.normal;
    default:
      return null;
  }
}

/// Basic TextInputType parser
TextInputType? _parseKeyboardType(String? keyboardType) {
  if (keyboardType == null) return TextInputType.text; // Default
  switch (keyboardType.toLowerCase()) {
    case 'text':
      return TextInputType.text;
    case 'number':
      return TextInputType.number;
    case 'phone':
      return TextInputType.phone;
    case 'email':
      return TextInputType.emailAddress;
    case 'url':
      return TextInputType.url;
    default:
      return TextInputType.text;
  }
}

TextAlign? _parseTextAlign(String? textAlign) {
  if (textAlign == null) return null;
  switch (textAlign.toLowerCase()) {
    case 'left':
      return TextAlign.left;
    case 'right':
      return TextAlign.right;
    case 'center':
      return TextAlign.center;
    case 'justify':
      return TextAlign.justify;
    case 'start':
      return TextAlign.start;
    case 'end':
      return TextAlign.end;
    default:
      return null;
  }
}

// Helper to parse BoxFit, assuming BoxFit enum string values
BoxFit? _parseBoxFit(String? fit) {
  if (fit == null) return null;
  return BoxFit.values.firstWhere((e) => e.toString() == 'BoxFit.$fit',
      orElse: () => BoxFit.contain);
}

// TODO: Add helper for Action execution binding
