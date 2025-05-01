import 'dart:convert';
import 'dart:io'; // For HttpStatus

import 'package:http/http.dart' as http;

/// Service responsible for fetching Devity Spec JSON from a backend.
class NetworkService {
  final http.Client _client;

  // Allow injecting an http.Client for testing
  NetworkService({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches the Spec JSON for a given [specId] from the [baseUrl].
  ///
  /// Throws [NetworkException] if the request fails or returns a non-200 status.
  /// Returns the raw JSON string on success.
  Future<String> fetchSpec(String specId, String baseUrl) async {
    // Ensure baseUrl doesn't end with a slash and endpoint doesn't start with one
    final cleanBaseUrl = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    final endpoint = 'sdk/specs/$specId';
    final url = Uri.parse('$cleanBaseUrl/$endpoint');

    print("NetworkService: Fetching spec from: $url");

    try {
      final response = await _client.get(url);

      if (response.statusCode == HttpStatus.ok) {
        // Check if the response body is valid JSON before returning
        try {
          json.decode(response.body); // Try parsing to validate
          print("NetworkService: Successfully fetched spec '$specId'");
          return response.body;
        } catch (e) {
          print("NetworkService: Error - Response body is not valid JSON.");
          throw NetworkException(
              'Invalid JSON received from server for spec \'$specId\'.',
              statusCode: response.statusCode);
        }
      } else {
        print(
            "NetworkService: Error fetching spec '$specId'. Status: ${response.statusCode}, Body: ${response.body}");
        throw NetworkException(
            'Failed to fetch spec \'$specId\'. Server returned status ${response.statusCode}',
            statusCode: response.statusCode);
      }
    } catch (e) {
      // Catch potential http exceptions (timeout, connection error) or others
      print("NetworkService: Exception during fetch for spec '$specId': $e");
      if (e is NetworkException) {
        rethrow; // Rethrow our specific exception
      }
      // Wrap other exceptions
      throw NetworkException(
          'An error occurred while fetching spec \'$specId\': ${e.toString()}');
    }
  }

  // Close the client when the service is disposed (if necessary)
  void dispose() {
    _client.close();
  }
}

/// Custom exception for network-related errors in the SDK.
class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException(this.message, {this.statusCode});

  @override
  String toString() =>
      'NetworkException: $message' +
      (statusCode != null ? ' (Status: $statusCode)' : '');
}
