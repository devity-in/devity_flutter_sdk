import 'package:flutter/foundation.dart';

/// Service for evaluating simple state binding expressions.
class ExpressionService {
  // Regular expression to match the pattern "@{state.variableName}"
  // It looks for "@{state." followed by a valid variable name (letters, numbers, underscore, starting with letter or underscore) and then "}"
  static final RegExp _stateBindingRegex =
      RegExp(r'^@\{state\.([a-zA-Z_][a-zA-Z0-9_]*)\}$');

  /// Evaluates a potential state binding expression against the provided state.
  ///
  /// Currently supports only direct state variable access like "@{state.variableName}".
  ///
  /// - [expression]: The string to evaluate (e.g., "Some text", "@{state.counter}"). Can be null.
  /// - [state]: The current screen state map.
  ///
  /// Returns the resolved value from the state if the expression is a valid binding
  /// and the variable exists. Otherwise, returns the original expression string.
  /// Converts basic types (int, double, bool) from state to String for display.
  /// Returns empty string for null expression or null value in state.
  static String evaluate(String? expression, Map<String, dynamic> state) {
    // Handle null expression input
    if (expression == null) {
      return '';
    }

    final match = _stateBindingRegex.firstMatch(expression);

    // Check if expression matches the binding pattern
    if (match != null) {
      final variableName = match.group(1); // Extract variable name

      // Check if variable name was captured and exists in the state map
      if (variableName != null && state.containsKey(variableName)) {
        final value = state[variableName]; // Get value from state

        // Convert common types to string for display purposes
        if (value is String) {
          return value;
        } else if (value is num) {
          // Handles both int and double
          return value.toString();
        } else if (value is bool) {
          return value.toString(); // e.g., "true" or "false"
        } else if (value == null) {
          // Represent null state value as empty string in the UI
          return '';
        } else {
          // For unhandled types (like complex objects), return a placeholder
          // Avoids potentially large/unhelpful toString() representations in the UI
          // Log a warning for developers
          debugPrint(
              'ExpressionService: Bound state variable \'$variableName\' has unhandled type ${value.runtimeType}. Returning placeholder.');
          return '[Object]'; // Placeholder for complex objects
        }
      } else {
        // Variable name was extracted but not found in the state map
        // Log a warning for developers
        debugPrint(
            'ExpressionService: Bound state variable \'$variableName\' not found in state. Check spec or initial state.');
        // Return empty string as a fallback when bound variable is missing
        return '';
      }
    }

    // If the expression doesn't match the binding pattern, return it as is
    return expression;
  }
}
