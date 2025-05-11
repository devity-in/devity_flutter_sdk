import 'package:devity_sdk/services/action_service.dart'; // Adjusted path
import 'package:flutter/widgets.dart';

class ActionServiceProvider extends InheritedWidget {
  const ActionServiceProvider({
    required this.actionService,
    required super.child,
    super.key,
  });
  final ActionService actionService;

  static ActionService? of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ActionServiceProvider>();
    return provider?.actionService;
  }

  @override
  bool updateShouldNotify(ActionServiceProvider oldWidget) {
    // If the ActionService instance itself can change, notify descendants.
    // For now, assuming it's instantiated once per spec load.
    return actionService != oldWidget.actionService;
  }
}
