import 'package:flutter/material.dart';
import 'package:devity_sdk/devity_sdk.dart'; // Import the main SDK package

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Configuration - Replace with your actual values
  // Use 10.0.2.2 to connect to host machine's localhost from Android emulator
  static const String devityBaseUrl =
      'http://10.0.2.2:8001'; // Corrected port based on docker-compose.yml
  // Use the UUID returned by the successful POST request
  static const String specId = '9701bb65-4562-42ad-a1a2-306dd2b369db';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devity SDK Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Use DevityRoot as the main content
      home: Scaffold(
        // Wrap DevityRoot in a Scaffold for basic app structure if needed
        // Or use DevityRoot directly as home if it provides its own Scaffold
        appBar: AppBar(
          title: Text('Devity SDK Example'),
        ),
        body: const DevityRoot(
          baseUrl: devityBaseUrl,
          specId: specId,
        ),
      ),
    );
  }
}
