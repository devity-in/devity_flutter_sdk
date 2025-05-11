import 'package:devity_sdk/core/models/padding_value.dart';
import 'package:flutter/material.dart'; // For Color

/// Represents common styling properties applicable to widgets and renderers.
class StyleModel {
  // Add other properties like margin, border, cornerRadius later

  const StyleModel({
    this.backgroundColor,
    this.textColor,
    this.padding,
  });

  /// Factory constructor to parse style properties from a JSON map.
  factory StyleModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const StyleModel(); // Return empty style if JSON is null
    }

    return StyleModel(
      backgroundColor: _parseColor(json['backgroundColor'] as String?),
      textColor: _parseColor(json['textColor'] as String?),
      padding: json['padding'] != null
          ? PaddingValue.fromJson(json['padding'])
          : null,
      // Parse other properties here
    );
  }
  final Color? backgroundColor;
  final Color? textColor;
  final PaddingValue? padding;

  /// Helper function to parse color strings (Hex format).
  /// Consider moving this to a shared utility if used elsewhere.
  static Color? _parseColor(String? hexColor) {
    if (hexColor == null || !hexColor.startsWith('#')) return null;
    try {
      final buffer = StringBuffer();
      if (hexColor.length == 7)
        buffer.write('ff'); // Add alpha if missing (fully opaque)
      buffer.write(hexColor.substring(1));
      if (buffer.length == 8) {
        // Handles #AARRGGBB and #RRGGBB (after adding ff)
        return Color(int.parse(buffer.toString(), radix: 16));
      } else {
        print(
          "Warning: Invalid color hex format '$hexColor'. Expected #RRGGBB or #AARRGGBB.",
        );
        return null;
      }
    } catch (e) {
      print("Error parsing color: '$hexColor'. Error: $e");
      return null;
    }
  }

  /// Serializes this StyleModel to a JSON map.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (backgroundColor != null) {
      json['backgroundColor'] = _colorToHex(backgroundColor!);
    }
    if (textColor != null) {
      json['textColor'] = _colorToHex(textColor!);
    }
    if (padding != null) {
      json['padding'] = padding!.toJson();
    }
    return json;
  }

  /// Helper function to convert Color objects to hex strings.
  static String _colorToHex(Color color) {
    // #AARRGGBB
    // return '#${color.alpha.toRadixString(16).padLeft(2, '0')}${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
    // Prefer #RRGGBB if alpha is FF
    if (color.alpha == 255) {
      return '#${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
    }
    // Include alpha if it's not FF
    return '#${color.alpha.toRadixString(16).padLeft(2, '0')}${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';
  }
}
