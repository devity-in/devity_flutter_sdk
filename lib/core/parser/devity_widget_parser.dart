import 'package:flutter/widgets.dart';

/// [DevityWidgetParser] is an abstract class that is used to
/// parse a JSON object into
/// a model and then parse the model into a widget.
///
/// This is used to create a parser for each type of STAC item asset.
/// For example, a [DevityTextParser] can be used to parse a STAC item asset
/// with a `"type": "text"` field into a [Text] widget.
abstract class DevityWidgetParser<T> {
  /// The `type` of the model that this parser can parse.
  ///
  /// This is used to identify the type of the model in the JSON object.
  String get type;

  /// Parses a JSON object into a model [T].
  ///
  /// This method should be implemented to parse a JSON object into a model.
  /// The JSON object is typically a part of the STAC widget.
  /// The model [T] should contain all the necessary data to build a widget.
  T getModel(Map<String, dynamic> json);

  /// Parses a model [T] into a [Widget].
  ///
  /// This method should be implemented to parse a model into a widget.
  /// The model [T] is the result of the [getModel] method.
  /// The [BuildContext] is the current build context.
  Widget parse(BuildContext context, T model);

  /// Parse a widget into a JSON object.
  ///
  /// This method should be implemented to parse a widget into a JSON object.
  /// The widget is the result of the [parse] method.
  Map<String, dynamic> export(Widget widget, BuildContext? buildContext);

  /// Check if the widget is the same type as the parser.
  ///
  /// This method should be implemented to check if the widget is the same
  /// type as the parser.
  bool matchWidgetForExport(Widget? widget) => widget.runtimeType == widgetType;

  /// The type of the widget that this parser can parse.
  Type get widgetType => T;
}
