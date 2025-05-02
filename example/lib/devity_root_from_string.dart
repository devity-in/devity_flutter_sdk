import 'package:devity_sdk/devity_sdk.dart';
import 'package:flutter/material.dart';

/// A widget similar to DevityRoot, but renders a spec from a hardcoded JSON string.
class DevityRootFromString extends StatefulWidget {
  final String specJsonString;
  final NavigationHandler? navigationHandler;

  const DevityRootFromString({
    super.key,
    required this.specJsonString,
    this.navigationHandler,
  });

  @override
  State<DevityRootFromString> createState() => _DevityRootFromStringState();
}

class _DevityRootFromStringState extends State<DevityRootFromString> {
  bool _isLoading = true;
  String? _error;
  SpecModel? _specModel;

  @override
  void initState() {
    super.initState();
    _parseSpec();
  }

  void _parseSpec() {
    setState(() {
      _isLoading = true;
      _error = null;
      _specModel = null;
    });

    try {
      // Use the parser from the SDK
      final parsedSpec = parseSpec(widget.specJsonString);
      setState(() {
        _specModel = parsedSpec;
        _isLoading = false;
      });
    } catch (e) {
      // Catch parsing errors or other unexpected issues
      print("DevityRootFromString: Error parsing spec - $e");
      setState(() {
        _error = "An error occurred while parsing the UI spec: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _error!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_specModel != null) {
      // Find the entry point screen
      final entryPointScreenId = _specModel!.entryPoint;
      final entryScreenModel = _specModel!.screens[entryPointScreenId];

      if (entryScreenModel != null) {
        // Render the screen using the DevityScreenRenderer
        // Pass the full specModel and navigation handler here
        return DevityScreenRenderer(
          screenModel: entryScreenModel,
          specModel: _specModel, // Pass the parsed spec model
          navigationHandler: widget.navigationHandler, // Pass handler
        );
      } else {
        return const Center(
          child: Text(
            "Error: Entry point screen not found in the spec.",
            style: TextStyle(color: Colors.red),
          ),
        );
      }
    }

    // Default empty state if something unexpected happens
    return const Center(child: Text("Initializing..."));
  }
}
