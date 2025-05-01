import 'package:devity_sdk/devity_sdk.dart';
import 'package:flutter/material.dart';

/// The root widget for rendering a Devity UI specification.
///
/// Fetches the spec JSON based on [specId] and [baseUrl],
/// parses it, and then uses [DevityScreenRenderer] to display the UI.
class DevityRoot extends StatefulWidget {
  final String specId;
  final String baseUrl; // Base URL of the Devity backend

  const DevityRoot({
    super.key,
    required this.specId,
    required this.baseUrl,
  });

  @override
  State<DevityRoot> createState() => _DevityRootState();
}

class _DevityRootState extends State<DevityRoot> {
  late final NetworkService _networkService;
  bool _isLoading = true;
  String? _error;
  SpecModel? _specModel;

  @override
  void initState() {
    super.initState();
    _networkService = NetworkService(); // Initialize the network service
    _fetchAndParseSpec();
  }

  Future<void> _fetchAndParseSpec() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _specModel = null;
    });

    try {
      final jsonString =
          await _networkService.fetchSpec(widget.specId, widget.baseUrl);
      final parsedSpec = parseSpec(jsonString); // Use the parser from the SDK
      setState(() {
        _specModel = parsedSpec;
        _isLoading = false;
      });
    } on NetworkException catch (e) {
      print("DevityRoot: Network error - $e");
      setState(() {
        _error = "Failed to load UI spec: ${e.message}";
        _isLoading = false;
      });
    } catch (e) {
      // Catch parsing errors or other unexpected issues
      print("DevityRoot: Error parsing spec or other error - $e");
      setState(() {
        _error = "An error occurred while loading the UI: ${e.toString()}";
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
        return DevityScreenRenderer(screenModel: entryScreenModel);
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

  @override
  void dispose() {
    _networkService.dispose(); // Close the http client
    super.dispose();
  }
}
