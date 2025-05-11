import 'package:devity_sdk/devity_sdk.dart';
import 'package:devity_sdk/models/spec_model.dart'; // This defines DevitySpec
import 'package:devity_sdk/providers/action_service_provider.dart';
import 'package:devity_sdk/services/action_service.dart';
import 'package:flutter/material.dart';

/// The root widget for rendering a Devity UI specification.
///
/// Fetches the spec JSON based on [specId] and [baseUrl],
/// parses it, and then uses [DevityScreenRenderer] to display the UI.
class DevityRoot extends StatefulWidget {
  // Add optional handler

  const DevityRoot({
    required this.specId,
    required this.baseUrl,
    super.key,
    this.navigationHandler, // Add to constructor
  });
  final String specId;
  final String baseUrl; // Base URL of the Devity backend
  final NavigationHandler? navigationHandler;

  @override
  State<DevityRoot> createState() => _DevityRootState();
}

class _DevityRootState extends State<DevityRoot> {
  late final NetworkService _networkService;
  bool _isLoading = true;
  String? _error;
  DevitySpec? _specModel; // Changed from SpecModel to DevitySpec
  ActionService? _actionService;

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
      _actionService = null; // Reset action service
    });

    try {
      final jsonString =
          await _networkService.fetchSpec(widget.specId, widget.baseUrl);
      final parsedSpec = parseSpec(jsonString) as DevitySpec;
      setState(() {
        _specModel = parsedSpec;
        _actionService = ActionService(
          _specModel!,
          navigationHandler: widget.navigationHandler,
        );
        _isLoading = false;
      });
    } on NetworkException catch (e) {
      print('DevityRoot: Network error - $e');
      setState(() {
        _error = 'Failed to load UI spec: ${e.message}';
        _isLoading = false;
      });
    } catch (e) {
      // Catch parsing errors or other unexpected issues
      print('DevityRoot: Error parsing spec or other error - $e');
      setState(() {
        _error = 'An error occurred while loading the UI: $e';
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
          padding: const EdgeInsets.all(16),
          child: Text(
            _error!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_specModel != null && _actionService != null) {
      final entryPointScreenId = _specModel!.entryPoint;
      final entryScreenModel = _specModel!.screens[entryPointScreenId];

      if (entryScreenModel != null) {
        // Wrap DevityScreenRenderer with ActionServiceProvider
        return ActionServiceProvider(
          actionService: _actionService!,
          child: DevityScreenRenderer(
            screenModel: entryScreenModel,
            specModel: _specModel, // Pass the full spec if needed by renderer
          ),
        );
      } else {
        return const Center(
          child: Text(
            'Error: Entry point screen not found in the spec.',
            style: TextStyle(color: Colors.red),
          ),
        );
      }
    }

    // Default empty state if something unexpected happens
    return const Center(child: Text('Initializing...'));
  }

  @override
  void dispose() {
    _networkService.dispose(); // Close the http client
    super.dispose();
  }
}
