import 'package:devity_sdk/core/core.dart';
import 'package:devity_sdk/parser/widget_parser/text/text_model.dart';
import 'package:flutter/material.dart';

/// This is the parser for the Text widget.
///
/// It extends the [DevityWidgetParser] class with the [TextModel] model.
///
/// The [type] getter returns the type of the widget, which is 'text'.
///
/// The [getModel] method returns the model from the JSON data.
///
/// The [parse] method returns the Text widget.
///
class TextParser extends DevityWidgetParser<TextModel> {
  @override
  String get type => 'text';

  @override
  TextModel getModel(Map<String, dynamic> json) {
    return TextModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, TextModel model) {
    return Text(model.data);
  }
}
