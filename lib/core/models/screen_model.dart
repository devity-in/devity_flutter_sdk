import './component_model.dart';
import './renderer_model.dart'; // Assume RendererModel exists
import './widget_model.dart'; // Assume WidgetModel exists

/// Model for Screens.
class ScreenModel extends ComponentModel {
  final String? backgroundColor;
  final ComponentModel? appBar; // Can be Widget or Renderer
  final ComponentModel body; // Can be Widget or Renderer
  final ComponentModel? bottomNavBar; // Can be Widget or Renderer
  final List<String>? onLoadActions;
  final Map<String, dynamic>? persistentData;

  ScreenModel({
    required String id,
    this.backgroundColor,
    this.appBar,
    required this.body,
    this.bottomNavBar,
    this.onLoadActions,
    this.persistentData,
  }) : super(id: id, type: 'Screen');

  // Remove the invalid factory constructor.
  // Parsing logic belongs in the parser service/functions.

  // factory ScreenModel.fromJson(Map<String, dynamic> json) {
  //   ...
  // }
}
