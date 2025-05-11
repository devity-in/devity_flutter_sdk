// ignore_for_file: avoid_dynamic_calls

import 'package:flutter/foundation.dart';

enum DevityActionType {
  navigate,
  showAlert,
  // Add other action types as they are implemented (e.g., apiCall, updateWidgetState)
  unknown,
}

DevityActionType _actionTypeFromString(String? type) {
  switch (type) {
    case 'Navigate':
      return DevityActionType.navigate;
    case 'ShowAlert':
      return DevityActionType.showAlert;
    default:
      debugPrint(r'Unknown DevityActionType: $type');
      return DevityActionType.unknown;
  }
}

abstract class DevityActionAttributes {
  const DevityActionAttributes();

  factory DevityActionAttributes.fromJson(
    DevityActionType actionType,
    Map<String, dynamic> json,
  ) {
    switch (actionType) {
      case DevityActionType.navigate:
        return NavigateActionAttributes.fromJson(json);
      case DevityActionType.showAlert:
        return ShowAlertActionAttributes.fromJson(json);
      case DevityActionType.unknown:
        // Return a default or throw an error for unknown types if preferred
        return const UnknownActionAttributes();
    }
  }
  Map<String, dynamic> toJson(); // For potential future use (e.g. debugging)
}

class NavigateActionAttributes extends DevityActionAttributes {
  const NavigateActionAttributes({
    required this.targetScreenId,
    this.transitionType,
    this.clearHistory = false,
    this.screenData,
  });

  factory NavigateActionAttributes.fromJson(Map<String, dynamic> json) {
    return NavigateActionAttributes(
      targetScreenId: json['targetScreenId'] as String,
      transitionType: json['transitionType'] as String?,
      clearHistory: (json['clearHistory'] as bool?) ?? false,
      screenData: json['screenData'] != null
          ? Map<String, dynamic>.from(json['screenData'] as Map)
          : null,
    );
  }
  final String targetScreenId;
  final String? transitionType;
  final bool clearHistory;
  final Map<String, dynamic>? screenData;

  @override
  Map<String, dynamic> toJson() => {
        'targetScreenId': targetScreenId,
        if (transitionType != null) 'transitionType': transitionType,
        'clearHistory': clearHistory,
        if (screenData != null) 'screenData': screenData,
      };
}

class ShowAlertActionAttributes extends DevityActionAttributes {
  // SDK can provide a default like "OK" if null

  const ShowAlertActionAttributes({
    required this.message,
    this.title,
    this.buttonText,
  });

  factory ShowAlertActionAttributes.fromJson(Map<String, dynamic> json) {
    return ShowAlertActionAttributes(
      title: json['title'] as String?,
      message: json['message'] as String,
      buttonText: json['buttonText'] as String?,
    );
  }
  final String? title;
  final String message;
  final String? buttonText;

  @override
  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title,
        'message': message,
        if (buttonText != null) 'buttonText': buttonText,
      };
}

class UnknownActionAttributes extends DevityActionAttributes {
  const UnknownActionAttributes();

  @override
  Map<String, dynamic> toJson() => {};
}

class DevityAction {
  const DevityAction({
    required this.id,
    required this.actionType,
    required this.attributes,
  });

  factory DevityAction.fromJson(String id, Map<String, dynamic> json) {
    final typeString = json['actionType'] as String?;
    final actionType = _actionTypeFromString(typeString);
    return DevityAction(
      id: id, // ID comes from the key in the actions map
      actionType: actionType,
      attributes: DevityActionAttributes.fromJson(
        actionType,
        json['attributes'] as Map<String, dynamic>? ?? {},
      ),
    );
  }
  final String id;
  final DevityActionType actionType;
  final DevityActionAttributes attributes;

  Map<String, dynamic> toJson() => {
        'id': id,
        'actionType':
            actionType.toString().split('.').last, // Convert enum to string
        'attributes': attributes.toJson(),
      };
}
