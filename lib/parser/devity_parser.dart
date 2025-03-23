import 'dart:convert';

import 'package:devity_sdk/core/core.dart';
import 'package:devity_sdk/parser/widget_parser/text/text_parser.dart';
import 'package:devity_sdk/services/logger_service.dart';
import 'package:flutter/material.dart';

/// The base class for all widget parsers.
/// It is used to parse a JSON object into a model and then
/// parse the model into a widget.
class DevityWidgetBuilder<T> {
  static final List<DevityWidgetParser<dynamic>> _parsers = [
    TextParser(),
  ];

  static final _widgetNameParserMap = <String, DevityWidgetParser<dynamic>>{};

  static bool _defaultParserInited = false;

  /// use this method for adding your custom widget parser
  static void addParser(DevityWidgetParser<dynamic> parser) {
    LoggerService.commonLog(
        "add custom widget parser, make sure you don't overwirte the widget type.");
    _parsers.add(parser);
    _widgetNameParserMap[parser.type] = parser;
  }

  /// use this method for adding your custom widget parser
  static void initDefaultParsersIfNess() {
    if (!_defaultParserInited) {
      for (final parser in _parsers) {
        _widgetNameParserMap[parser.type] = parser;
      }
      _defaultParserInited = true;
    }
  }

  /// helps to build a widget from a json
  static Widget? build(
    String json,
    BuildContext buildContext,
    ClickListener listener,
  ) {
    initDefaultParsersIfNess();
    final map = jsonDecode(json) as Map<String, dynamic>?;
    final listener0 = listener;
    final widget = buildFromMap(map, buildContext, listener0);
    return widget;
  }

  /// helps to build a widget from a json
  static Widget? buildFromMap(Map<String, dynamic>? map,
      BuildContext buildContext, ClickListener? listener) {
    initDefaultParsersIfNess();
    if (map == null) {
      return null;
    }
    final widgetName = map['type'] as String?;
    if (widgetName == null) {
      return null;
    }
    final parser = _widgetNameParserMap[widgetName];
    if (parser != null) {
      final model = parser.getModel(map);
      return parser.parse(buildContext, model);
    }
    LoggerService.commonLog('Not support parser type: $widgetName');
    return null;
  }

  /// helps to build a list of widgets from a list of json
  static List<Widget> buildWidgets(List<dynamic> values,
      BuildContext buildContext, ClickListener? listener) {
    initDefaultParsersIfNess();
    final rt = <Widget>[];
    for (final value in values) {
      final buildFromMap2 =
          buildFromMap(value as Map<String, dynamic>?, buildContext, listener);
      if (buildFromMap2 != null) {
        rt.add(buildFromMap2);
      }
    }
    return rt;
  }

  /// helps to export a widget to a json
  static Map<String, dynamic>? export(
      Widget widget, BuildContext? buildContext) {
    initDefaultParsersIfNess();
    final parser = _findMatchedWidgetParserForExport(widget);
    if (parser != null) {
      return parser.export(widget, buildContext);
    }
    LoggerService.commonLog(
        "Can't find WidgetParser for Type ${widget.runtimeType} to export.");
    return null;
  }

  /// helps to export a list of widgets to a list of json
  static List<Map<String, dynamic>?> exportWidgets(
      List<Widget> widgets, BuildContext? buildContext) {
    initDefaultParsersIfNess();
    final rt = <Map<String, dynamic>?>[];
    for (final widget in widgets) {
      rt.add(export(widget, buildContext));
    }
    return rt;
  }

  /// helps to export a list of widgets to a list of json
  static DevityWidgetParser<dynamic>? _findMatchedWidgetParserForExport(
      Widget? widget) {
    for (final parser in _parsers) {
      if (parser.matchWidgetForExport(widget)) {
        return parser;
      }
    }
    return null;
  }
}

abstract class ClickListener {
  void onClicked(String? event);
}

class NonResponseWidgetClickListener implements ClickListener {
  @override
  void onClicked(String? event) {
    LoggerService.commonLog('receiver click event: ' + event!);
    print('receiver click event: ' + event);
  }
}
