import 'package:devity_sdk/core/enumeration.dart';
import 'package:flutter/material.dart';

/// DevityApp class is the entry point for the Devity SDK.
class DevityApp extends StatelessWidget {
  /// Creates a DevityApp.
  ///

  const DevityApp({
    required this.dataSource,
    required this.path,
    super.key,
  });

  /// The data source for the app.
  final DevityAppDataSource dataSource;

  /// The path to the app.
  final String path;
  @override
  Widget build(BuildContext context) {
    return MaterialApp();
  }
}
