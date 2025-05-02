import 'package:flutter/material.dart';
import 'package:devity_sdk/devity_sdk.dart'; // Import the main SDK package
// Import the new widget
import './devity_root_from_string.dart';

void main() {
  runApp(const MyApp());
}

// Sample JSON Spec for testing state binding, navigation, and alerts
const String sampleSpecJson = '''
{
  "specVersion": "0.1.0",
  "entryPoint": "mainScreen",
  "screens": {
    "mainScreen": {
      "id": "mainScreen",
      "type": "Screen",
      "persistentData": {
        "counter": 0,
        "userName": "Alice"
      },
      "body": {
        "id": "mainColumn",
        "type": "Renderer",
        "rendererType": "Column",
        "children": [
          {
            "id": "welcomeText",
            "type": "Widget",
            "widgetType": "Text",
            "attributes": {
              "text": "Welcome, @{state.userName}! Counter: @{state.counter}",
              "fontSize": 20.0
            }
          },
          {
            "id": "incrementButton",
            "type": "Widget",
            "widgetType": "Button",
            "attributes": {
              "text": "Set Counter to 5"
            },
            "onClickActionIds": ["incrementAction"]
          },
          {
            "id": "navButton",
            "type": "Widget",
            "widgetType": "Button",
            "attributes": {
              "text": "Go to Screen 2"
            },
            "onClickActionIds": ["navigateToScreen2"]
          }
        ]
      }
    },
    "screen2": {
      "id": "screen2",
      "type": "Screen",
      "body": {
        "id": "screen2Column",
        "type": "Renderer",
        "rendererType": "Column",
        "children": [
          {
            "id": "screen2Text",
            "type": "Widget",
            "widgetType": "Text",
            "attributes": {
              "text": "This is Screen 2. Counter is @{state.counter}"
            }
          },
          {
            "id": "alertButton",
            "type": "Widget",
            "widgetType": "Button",
            "attributes": {
              "text": "Show Alert"
            },
            "onClickActionIds": ["showAlertAction"]
          },
          {
            "id": "navBackButton",
            "type": "Widget",
            "widgetType": "Button",
            "attributes": {
              "text": "Back to Main"
            },
            "onClickActionIds": ["navigateBackToMain"]
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
    },
    "navigateToScreen2": {
      "id": "navigateToScreen2",
      "type": "Action",
      "actionType": "Navigate",
      "attributes": {
        "screenId": "screen2"
      }
    },
    "navigateBackToMain": {
      "id": "navigateBackToMain",
      "type": "Action",
      "actionType": "Navigate",
      "attributes": {
        "screenId": "mainScreen" // Navigate back by ID
      }
    },
    "showAlertAction": {
      "id": "showAlertAction",
      "type": "Action",
      "actionType": "ShowAlert",
      "attributes": {
        "title": "Hello from Devity!",
        "message": "The counter value is @{state.counter}."
      }
    }
  }
}
''';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Use a GlobalKey for Navigator access if needed outside build context
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  // Define the navigation handler callback
  void _handleNavigation(String screenId) {
    print("Example App: Navigation requested to screen: $screenId");
    // Here you would implement your app's navigation logic.
    // For this simple example, we'll use Navigator.pushReplacementNamed
    // Assuming screen IDs match route names.
    _navigatorKey.currentState?.pushReplacementNamed('/$screenId');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey, // Assign key
      title: 'Devity SDK Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define routes matching screen IDs
      routes: {
        '/mainScreen': (context) => Scaffold(
              appBar: AppBar(title: Text('Devity SDK Example - Main')),
              body: DevityRootFromString(
                specJsonString: sampleSpecJson,
                navigationHandler: _handleNavigation, // Pass handler
              ),
            ),
        '/screen2': (context) => Scaffold(
              appBar: AppBar(title: Text('Devity SDK Example - Screen 2')),
              // IMPORTANT: DevityRootFromString currently only renders the entryPoint.
              // To show screen2, we need DevityRoot to handle screen changes internally,
              // OR we parse the spec here and pass the correct ScreenModel.
              // For now, let's just show screen2's content *statically*.
              // This highlights a limitation to address later.
              // A better approach: Have DevityRoot manage the current screen internally.
              body: Center(
                  child: Text(
                      "Screen 2 Placeholder - Navigation needs SDK enhancement")),
              /* // Ideal but requires SDK changes:
          DevityRootFromString(
             specJsonString: sampleSpecJson,
             initialScreenId: 'screen2', // Need to add this capability
             navigationHandler: _handleNavigation,
           ),*/
            ),
      },
      initialRoute: '/mainScreen', // Start at mainScreen
      // home: Scaffold(...), // Remove direct home if using initialRoute
    );
  }
}
