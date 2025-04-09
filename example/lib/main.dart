import 'package:devity_sdk/core/enumeration.dart';
import 'package:flutter/material.dart';
import 'package:devity_sdk/devity_sdk.dart';

void main() {
  runApp(
    const DevityApp(
      dataSource: DevityAppDataSource.local,
      path: './example/lib/main.json',
    ),
  );
}
