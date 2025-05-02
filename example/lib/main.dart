import 'package:flutter/material.dart';
import 'package:devity_sdk/devity_sdk.dart'; // Import the main SDK package
// Remove DevityRootFromString import
// import './devity_root_from_string.dart';

void main() {
  runApp(const MyApp());
}

// Remove sample JSON
// const String sampleSpecJson = ... ;

class MyApp extends StatefulWidget {
  // Changed back to StatefulWidget
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Changed back to _MyAppState

  // Backend Configuration (Ensure backend is running!)
  // Use 10.0.2.2 for Android Emulator accessing host localhost
  // Use localhost or 127.0.0.1 if running web/desktop directly on host
  static const String devityBaseUrl =
      'http://10.0.2.2:8001'; // Adjust if needed
  // This ID likely needs to be updated with one from your backend DB
  static String specId = '9701bb65-4562-42ad-a1a2-306dd2b369db';

  // Define the navigation handler callback
  void _handleNavigation(String screenId) {
    print("Example App: Navigation requested to screen: $screenId");
    // Simple placeholder for navigation - real app would use router
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Navigation Action Triggered"),
              content: Text("Requested navigation to screen ID: $screenId"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text("OK"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove navigatorKey and routes if not using local routing for testing
      title: 'Devity SDK Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Devity SDK Example - Backend'),
        ),
        // Use the original DevityRoot, fetching from backend
        body: DevityRoot(
          baseUrl: devityBaseUrl,
          specId: specId,
          navigationHandler: _handleNavigation, // Pass handler
        ),
      ),
      // Remove routes if using DevityRoot only
      // routes: { ... },
      // initialRoute: '...',
    );
  }
}
