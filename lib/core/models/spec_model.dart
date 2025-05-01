import './screen_model.dart';
import './action_model.dart';
import './rule_model.dart';

class SpecModel {
  final String specVersion;
  final String specId;
  final int version;
  final DateTime createdAt;
  final String entryPoint;
  final Map<String, dynamic>? globalData;
  final Map<String, ScreenModel> screens;
  final Map<String, ActionModel>? actions;
  final Map<String, RuleModel>? rules;

  SpecModel({
    required this.specVersion,
    required this.specId,
    required this.version,
    required this.createdAt,
    required this.entryPoint,
    this.globalData,
    required this.screens,
    this.actions,
    this.rules,
  });
}
