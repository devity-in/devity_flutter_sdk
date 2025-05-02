import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/// Represents the dynamic state of a rendered Devity screen.
@immutable // Encourage immutability
class DevityScreenState extends Equatable {
  /// The dynamic data map for the screen.
  /// Keys are variable names, values can be any JSON-representable type.
  final Map<String, dynamic> data;

  const DevityScreenState({
    Map<String, dynamic>? initialData,
  }) : data = initialData ?? const {}; // Initialize with empty map if null

  /// Creates a new state by merging the current data with updates.
  DevityScreenState update(Map<String, dynamic> updates) {
    // Create a new map with the existing data and overwrite/add updates
    final newData = Map<String, dynamic>.from(data);
    newData.addAll(updates);
    // Return a new instance with the updated map
    return DevityScreenState(initialData: newData);
  }

  @override
  List<Object?> get props => [data];

  // Optional: Helper to get a value by key with type safety?
  T? getValue<T>(String key) {
    if (data.containsKey(key) && data[key] is T) {
      return data[key] as T?;
    }
    return null;
  }
}
