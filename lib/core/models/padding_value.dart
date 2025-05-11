import 'package:flutter/material.dart'; // For EdgeInsets

/// Represents padding values defined in the spec.
///
/// Can be parsed from a JSON object like:
/// {"top": 8, "bottom": 8, "left": 16, "right": 16}
/// or {"all": 10}
class PaddingValue {
  const PaddingValue({
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  });

  /// Creates a PaddingValue with uniform padding on all sides.
  const PaddingValue.all(double value)
      : this(top: value, bottom: value, left: value, right: value);

  /// Factory constructor to parse padding values from a JSON map.
  factory PaddingValue.fromJson(dynamic json) {
    if (json is num) {
      // Handle case where padding is just a single number (treat as uniform)
      final value = json.toDouble();
      return PaddingValue.all(value);
    } else if (json is Map<String, dynamic>) {
      final all = json['all'] as num?;
      if (all != null) {
        final value = all.toDouble();
        return PaddingValue.all(value);
      } else {
        return PaddingValue(
          top: (json['top'] as num?)?.toDouble() ?? 0.0,
          bottom: (json['bottom'] as num?)?.toDouble() ?? 0.0,
          left: (json['left'] as num?)?.toDouble() ?? 0.0,
          right: (json['right'] as num?)?.toDouble() ?? 0.0,
        );
      }
    } else {
      // Invalid format, return zero padding
      print(
        'Warning: Invalid padding format received: $json. Defaulting to zero.',
      );
      return const PaddingValue();
    }
  }
  final double top;
  final double bottom;
  final double left;
  final double right;

  /// Converts this PaddingValue to Flutter's EdgeInsets.
  EdgeInsets get edgeInsets => EdgeInsets.fromLTRB(left, top, right, bottom);

  /// Serializes this PaddingValue to a JSON map.
  Map<String, dynamic> toJson() {
    // Check if all values are the same for a simpler "all" representation
    if (top == bottom && top == left && top == right) {
      return {'all': top};
    }
    return {
      'top': top,
      'bottom': bottom,
      'left': left,
      'right': right,
    };
  }
}
