import 'package:devity_sdk/services/expression_service.dart';
import 'package:test/test.dart';

void main() {
  group('ExpressionService.evaluate', () {
    final Map<String, dynamic> testState = {
      'stringValue': 'Hello World',
      'intValue': 123,
      'doubleValue': 45.67,
      'boolValueTrue': true,
      'boolValueFalse': false,
      'nullValue': null,
      'complexValue': {'a': 1},
    };

    test('should return empty string for null expression', () {
      expect(ExpressionService.evaluate(null, testState), '');
    });

    test('should return original string for non-binding expression', () {
      expect(ExpressionService.evaluate('Just a string', testState),
          'Just a string');
    });

    test('should evaluate valid string binding', () {
      expect(ExpressionService.evaluate('@{state.stringValue}', testState),
          'Hello World');
    });

    test('should evaluate valid int binding and convert to string', () {
      expect(ExpressionService.evaluate('@{state.intValue}', testState), '123');
    });

    test('should evaluate valid double binding and convert to string', () {
      expect(ExpressionService.evaluate('@{state.doubleValue}', testState),
          '45.67');
    });

    test('should evaluate valid true bool binding and convert to string', () {
      expect(ExpressionService.evaluate('@{state.boolValueTrue}', testState),
          'true');
    });

    test('should evaluate valid false bool binding and convert to string', () {
      expect(ExpressionService.evaluate('@{state.boolValueFalse}', testState),
          'false');
    });

    test('should evaluate valid null binding and return empty string', () {
      expect(ExpressionService.evaluate('@{state.nullValue}', testState), '');
    });

    test('should return placeholder for complex object binding', () {
      expect(ExpressionService.evaluate('@{state.complexValue}', testState),
          '[Object]');
    });

    test('should return empty string for binding non-existent variable', () {
      expect(
          ExpressionService.evaluate('@{state.missingValue}', testState), '');
    });

    test(
        'should return original string for invalid syntax (missing closing brace)',
        () {
      expect(ExpressionService.evaluate('@{state.stringValue', testState),
          '@{state.stringValue');
    });

    test('should return original string for invalid syntax (missing variable)',
        () {
      expect(ExpressionService.evaluate('@{state.}', testState), '@{state.}');
    });

    test('should return original string for invalid syntax (no state prefix)',
        () {
      expect(ExpressionService.evaluate('@{stringValue}', testState),
          '@{stringValue}');
    });

    test('should return original string for plain variable name', () {
      expect(
          ExpressionService.evaluate('stringValue', testState), 'stringValue');
    });
  });
}
