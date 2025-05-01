library devity_sdk;

// Export Core Models and Enums
export 'core/core.dart';

// Export Parser Logic
export 'parser/devity_parser.dart';

// Export Rendering Logic
export 'rendering/devity_renderer.dart';

// Export Services
export 'services/network_service.dart';

// Export Main SDK Widget
export 'devity_root.dart';

// TODO: Export State Management Service when added
// TODO: Remove old DevityApp class? -> Seems replaced by DevityRoot

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
