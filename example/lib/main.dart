import 'package:flutter/material.dart';
import 'package:devity_sdk/devity_sdk.dart'; // Import the main SDK package
// Import the new widget
import './devity_root_from_string.dart';

void main() {
  runApp(const MyApp());
}

// Sample JSON Spec for testing state binding
const String sampleSpecJson = '''
{
  "specVersion": "0.1.0",
  "entryPoint": "mainScreen",
  "screens": {
    "mainScreen": {
      "id": "mainScreen",
      "type": "Screen",
      "persistentData": {
        "counter": 0
      },
      "body": {
        "id": "mainColumn",
        "type": "Renderer",
        "rendererType": "Column",
        "children": [
          {
            "id": "counterText",
            "type": "Widget",
            "widgetType": "Text",
            "attributes": {
              "text": "@{state.counter}",
              "fontSize": 24.0
            }
          },
          {
            "id": "incrementButton",
            "type": "Widget",
            "widgetType": "Button",
            "attributes": {
              "text": "Increment (Sets to 5)"
            },
            "onClickActionIds": ["incrementAction"]
          }
        ]
      }
    }
  },
  "actions": {
    "incrementAction": {
      "id": "incrementAction",
      "type": "Action",
      "actionType": "setState",
      "attributes": {
        "updates": {
          "counter": 5 
        }
      }
    }
  }
}
''';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Remove backend configuration
  // static const String devityBaseUrl =
  //     'http://10.0.2.2:8001';
  // static const String specId = '9701bb65-4562-42ad-a1a2-306dd2b369db';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devity SDK Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Devity SDK Example - Binding'),
        ),
        // Use DevityRootFromString with the sample JSON
        body: const DevityRootFromString(
          specJsonString: sampleSpecJson,
        ),
      ),
    );
  }
}
