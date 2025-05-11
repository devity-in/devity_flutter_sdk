import 'package:devity_sdk/core/models/screen_model.dart'; // Import the correct ScreenModel
import 'package:devity_sdk/models/action_model.dart'; // Assuming action_model.dart is in the same directory

// Placeholder for ScreenModel, replace with actual import if available
// import './screen_model.dart';

// Remove ComponentModel placeholders, as parsing is deferred to renderer
// abstract class ComponentModel { ... }
// ComponentModel? _parseComponentModel(Map<String, dynamic> json) { ... }
// class DummyComponentModel extends ComponentModel { ... }

// For now, using Map<String, dynamic> for screens value type
// class ScreenModel {
//   // Changed body to dynamic
//
//   const ScreenModel({
//     required this.id,
//     required this.type,
//     this.onLoadActions,
//     this.persistentData,
//     this.backgroundColor,
//     this.body, // Body is now dynamic
//   });
//
//   factory ScreenModel.fromJson(Map<String, dynamic> json) {
//     return ScreenModel(
//       id: json['id'] as String? ?? '',
//       type: json['type'] as String? ?? 'Screen',
//       onLoadActions: (json['onLoadActions'] as List<dynamic>?)
//           ?.map((e) => e as String)
//           .toList(),
//       persistentData: json['persistentData'] as Map<String, dynamic>?,
//       backgroundColor: json['backgroundColor'] as String?,
//       body: json['body'], // Assign body directly as dynamic
//     );
//   }
//   // Added body (typed to placeholder ComponentModel)
//
//   final String id;
//   final String type;
//   final List<String>? onLoadActions;
//   final Map<String, dynamic>? persistentData;
//   final String? backgroundColor;
//   final dynamic body;
//   // Added for onLoadActions processing
//   // Add other screen properties as needed e.g. body, backgroundColor
//
//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{
//       'id': id,
//       'type': type,
//     };
//     if (onLoadActions != null) {
//       data['onLoadActions'] = onLoadActions;
//     }
//     if (persistentData != null) {
//       data['persistentData'] = persistentData;
//     }
//     if (backgroundColor != null) {
//       data['backgroundColor'] = backgroundColor;
//     }
//     if (body != null) {
//       // How to serialize dynamic body? For now, assume it can be directly serialized if it's a Map/List/Primitive.
//       // If body contains complex objects that aren't directly serializable, this needs more thought.
//       data['body'] = body;
//     }
//     return data;
//   }
// }

// Basic placeholder for the main Spec model.
// This will need to be expanded significantly to parse the entire spec.
class DevitySpec {
  // Added screens map

  const DevitySpec({
    required this.specVersion,
    required this.specId,
    required this.version,
    required this.entryPoint,
    this.actions = const {},
    this.screens = const {}, // Initialize screens
  });

  factory DevitySpec.fromJson(Map<String, dynamic> json) {
    final actionsMap = <String, DevityAction>{};
    final rawActions = json['actions'] as Map<String, dynamic>? ?? {};
    rawActions.forEach((key, value) {
      actionsMap[key] =
          DevityAction.fromJson(key, value as Map<String, dynamic>);
    });

    final screensMap = <String, ScreenModel>{}; // Use imported ScreenModel
    final rawScreens = json['screens'] as Map<String, dynamic>? ?? {};
    rawScreens.forEach((key, value) {
      // Use imported ScreenModel.fromJson
      screensMap[key] = ScreenModel.fromJson(value as Map<String, dynamic>);
    });

    return DevitySpec(
      specVersion: json['specVersion'] as String? ?? '0.0.0',
      specId: json['specId'] as String? ?? 'unknown_spec',
      version: json['version'] as int? ?? 0,
      entryPoint: json['entryPoint'] as String? ?? '',
      actions: actionsMap,
      screens: screensMap, // Parse screens
    );
  }
  // Required for ActionService
  // Add other top-level fields like screens, globalData etc. as needed

  final String specVersion;
  final String specId;
  final int version;
  final String entryPoint;
  final Map<String, DevityAction> actions;
  final Map<String, ScreenModel> screens;

  Map<String, dynamic> toJson() => {
        'specVersion': specVersion,
        'specId': specId,
        'version': version,
        'entryPoint': entryPoint,
        'actions': actions.map((key, value) => MapEntry(key, value.toJson())),
        'screens': screens.map(
          (key, value) => MapEntry(key, value.toJson()),
        ), // Serialize screens
      };
}
