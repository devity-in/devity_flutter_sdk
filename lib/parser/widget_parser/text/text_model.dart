import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_model.freezed.dart';
part 'text_model.g.dart';

/// A model for the [Text] class.
///
@freezed
class TextModel with _$TextModel {
  /// Creates a [TextModel].
  const factory TextModel({
    required String data,
    @Default([]) List<TextSpanModel> children,
    TextStyleModel? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    String? selectionColor,
  }) = _TextModel;

  /// Creates a [TextModel] from a JSON object.
  factory TextModel.fromJson(Map<String, dynamic> json) =>
      _$TextModelFromJson(json);

  /// Converts this [TextModel] to a JSON object.
  @override
  Map<String, dynamic> toJson() => _$TextModelToJson(this as _TextModel);
}

/// A model for the [TextSpan] class.
///
@freezed
class TextSpanModel with _$TextSpanModel {
  /// Creates a [TextSpanModel].
  const factory TextSpanModel({
    required String data,
    TextStyleModel? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    String? selectionColor,
  }) = _TextSpanModel;

  /// Creates a [TextSpanModel] from a JSON object.
  factory TextSpanModel.fromJson(Map<String, dynamic> json) =>
      _$TextSpanModelFromJson(json);

  /// Converts this [TextSpanModel] to a JSON object.
  @override
  Map<String, dynamic> toJson() =>
      _$TextSpanModelToJson(this as _TextSpanModel);
}

/// A model for the [TextStyle] class.
///
@freezed
class TextStyleModel with _$TextStyleModel {
  /// Creates a [TextStyleModel].
  const factory TextStyleModel({
    @ColorConverter() Color? color,
    double? fontSize,
  }) = _TextStyleModel;

  /// Creates a [TextStyleModel] from a JSON object.
  factory TextStyleModel.fromJson(Map<String, dynamic> json) =>
      _$TextStyleModelFromJson(json);

  /// Converts this [TextStyleModel] to a JSON object.
  @override
  Map<String, dynamic> toJson() =>
      _$TextStyleModelToJson(this as _TextStyleModel);
}

/// A converter that can convert a [Color] to a [int] and vice versa.
class ColorConverter extends JsonConverter<Color?, dynamic> {
  /// Creates a const [ColorConverter].
  const ColorConverter();

  @override
  Color? fromJson(dynamic json) {
    if (json is int) {
      return Color(json);
    }
    return null;
  }

  @override
  int? toJson(Color? color) {
    return color?.value;
  }
}
