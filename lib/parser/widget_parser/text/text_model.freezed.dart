// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TextModel {
  String get data;
  List<TextSpanModel> get children;
  TextStyleModel? get style;
  TextAlign? get textAlign;
  TextDirection? get textDirection;
  bool? get softWrap;
  TextOverflow? get overflow;
  double? get textScaleFactor;
  int? get maxLines;
  String? get semanticsLabel;
  TextWidthBasis? get textWidthBasis;
  String? get selectionColor;

  /// Create a copy of TextModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextModelCopyWith<TextModel> get copyWith =>
      _$TextModelCopyWithImpl<TextModel>(this as TextModel, _$identity);

  /// Serializes this TextModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextModel &&
            (identical(other.data, data) || other.data == data) &&
            const DeepCollectionEquality().equals(other.children, children) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.textAlign, textAlign) ||
                other.textAlign == textAlign) &&
            (identical(other.textDirection, textDirection) ||
                other.textDirection == textDirection) &&
            (identical(other.softWrap, softWrap) ||
                other.softWrap == softWrap) &&
            (identical(other.overflow, overflow) ||
                other.overflow == overflow) &&
            (identical(other.textScaleFactor, textScaleFactor) ||
                other.textScaleFactor == textScaleFactor) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.semanticsLabel, semanticsLabel) ||
                other.semanticsLabel == semanticsLabel) &&
            (identical(other.textWidthBasis, textWidthBasis) ||
                other.textWidthBasis == textWidthBasis) &&
            (identical(other.selectionColor, selectionColor) ||
                other.selectionColor == selectionColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      data,
      const DeepCollectionEquality().hash(children),
      style,
      textAlign,
      textDirection,
      softWrap,
      overflow,
      textScaleFactor,
      maxLines,
      semanticsLabel,
      textWidthBasis,
      selectionColor);

  @override
  String toString() {
    return 'TextModel(data: $data, children: $children, style: $style, textAlign: $textAlign, textDirection: $textDirection, softWrap: $softWrap, overflow: $overflow, textScaleFactor: $textScaleFactor, maxLines: $maxLines, semanticsLabel: $semanticsLabel, textWidthBasis: $textWidthBasis, selectionColor: $selectionColor)';
  }
}

/// @nodoc
abstract mixin class $TextModelCopyWith<$Res> {
  factory $TextModelCopyWith(TextModel value, $Res Function(TextModel) _then) =
      _$TextModelCopyWithImpl;
  @useResult
  $Res call(
      {String data,
      List<TextSpanModel> children,
      TextStyleModel? style,
      TextAlign? textAlign,
      TextDirection? textDirection,
      bool? softWrap,
      TextOverflow? overflow,
      double? textScaleFactor,
      int? maxLines,
      String? semanticsLabel,
      TextWidthBasis? textWidthBasis,
      String? selectionColor});

  $TextStyleModelCopyWith<$Res>? get style;
}

/// @nodoc
class _$TextModelCopyWithImpl<$Res> implements $TextModelCopyWith<$Res> {
  _$TextModelCopyWithImpl(this._self, this._then);

  final TextModel _self;
  final $Res Function(TextModel) _then;

  /// Create a copy of TextModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? children = null,
    Object? style = freezed,
    Object? textAlign = freezed,
    Object? textDirection = freezed,
    Object? softWrap = freezed,
    Object? overflow = freezed,
    Object? textScaleFactor = freezed,
    Object? maxLines = freezed,
    Object? semanticsLabel = freezed,
    Object? textWidthBasis = freezed,
    Object? selectionColor = freezed,
  }) {
    return _then(_self.copyWith(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _self.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TextSpanModel>,
      style: freezed == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyleModel?,
      textAlign: freezed == textAlign
          ? _self.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as TextAlign?,
      textDirection: freezed == textDirection
          ? _self.textDirection
          : textDirection // ignore: cast_nullable_to_non_nullable
              as TextDirection?,
      softWrap: freezed == softWrap
          ? _self.softWrap
          : softWrap // ignore: cast_nullable_to_non_nullable
              as bool?,
      overflow: freezed == overflow
          ? _self.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as TextOverflow?,
      textScaleFactor: freezed == textScaleFactor
          ? _self.textScaleFactor
          : textScaleFactor // ignore: cast_nullable_to_non_nullable
              as double?,
      maxLines: freezed == maxLines
          ? _self.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      semanticsLabel: freezed == semanticsLabel
          ? _self.semanticsLabel
          : semanticsLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      textWidthBasis: freezed == textWidthBasis
          ? _self.textWidthBasis
          : textWidthBasis // ignore: cast_nullable_to_non_nullable
              as TextWidthBasis?,
      selectionColor: freezed == selectionColor
          ? _self.selectionColor
          : selectionColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TextModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleModelCopyWith<$Res>? get style {
    if (_self.style == null) {
      return null;
    }

    return $TextStyleModelCopyWith<$Res>(_self.style!, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _TextModel implements TextModel {
  const _TextModel(
      {required this.data,
      final List<TextSpanModel> children = const [],
      this.style,
      this.textAlign,
      this.textDirection,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.selectionColor})
      : _children = children;
  factory _TextModel.fromJson(Map<String, dynamic> json) =>
      _$TextModelFromJson(json);

  @override
  final String data;
  final List<TextSpanModel> _children;
  @override
  @JsonKey()
  List<TextSpanModel> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final TextStyleModel? style;
  @override
  final TextAlign? textAlign;
  @override
  final TextDirection? textDirection;
  @override
  final bool? softWrap;
  @override
  final TextOverflow? overflow;
  @override
  final double? textScaleFactor;
  @override
  final int? maxLines;
  @override
  final String? semanticsLabel;
  @override
  final TextWidthBasis? textWidthBasis;
  @override
  final String? selectionColor;

  /// Create a copy of TextModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TextModelCopyWith<_TextModel> get copyWith =>
      __$TextModelCopyWithImpl<_TextModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TextModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TextModel &&
            (identical(other.data, data) || other.data == data) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.textAlign, textAlign) ||
                other.textAlign == textAlign) &&
            (identical(other.textDirection, textDirection) ||
                other.textDirection == textDirection) &&
            (identical(other.softWrap, softWrap) ||
                other.softWrap == softWrap) &&
            (identical(other.overflow, overflow) ||
                other.overflow == overflow) &&
            (identical(other.textScaleFactor, textScaleFactor) ||
                other.textScaleFactor == textScaleFactor) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.semanticsLabel, semanticsLabel) ||
                other.semanticsLabel == semanticsLabel) &&
            (identical(other.textWidthBasis, textWidthBasis) ||
                other.textWidthBasis == textWidthBasis) &&
            (identical(other.selectionColor, selectionColor) ||
                other.selectionColor == selectionColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      data,
      const DeepCollectionEquality().hash(_children),
      style,
      textAlign,
      textDirection,
      softWrap,
      overflow,
      textScaleFactor,
      maxLines,
      semanticsLabel,
      textWidthBasis,
      selectionColor);

  @override
  String toString() {
    return 'TextModel(data: $data, children: $children, style: $style, textAlign: $textAlign, textDirection: $textDirection, softWrap: $softWrap, overflow: $overflow, textScaleFactor: $textScaleFactor, maxLines: $maxLines, semanticsLabel: $semanticsLabel, textWidthBasis: $textWidthBasis, selectionColor: $selectionColor)';
  }
}

/// @nodoc
abstract mixin class _$TextModelCopyWith<$Res>
    implements $TextModelCopyWith<$Res> {
  factory _$TextModelCopyWith(
          _TextModel value, $Res Function(_TextModel) _then) =
      __$TextModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String data,
      List<TextSpanModel> children,
      TextStyleModel? style,
      TextAlign? textAlign,
      TextDirection? textDirection,
      bool? softWrap,
      TextOverflow? overflow,
      double? textScaleFactor,
      int? maxLines,
      String? semanticsLabel,
      TextWidthBasis? textWidthBasis,
      String? selectionColor});

  @override
  $TextStyleModelCopyWith<$Res>? get style;
}

/// @nodoc
class __$TextModelCopyWithImpl<$Res> implements _$TextModelCopyWith<$Res> {
  __$TextModelCopyWithImpl(this._self, this._then);

  final _TextModel _self;
  final $Res Function(_TextModel) _then;

  /// Create a copy of TextModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? children = null,
    Object? style = freezed,
    Object? textAlign = freezed,
    Object? textDirection = freezed,
    Object? softWrap = freezed,
    Object? overflow = freezed,
    Object? textScaleFactor = freezed,
    Object? maxLines = freezed,
    Object? semanticsLabel = freezed,
    Object? textWidthBasis = freezed,
    Object? selectionColor = freezed,
  }) {
    return _then(_TextModel(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      children: null == children
          ? _self._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<TextSpanModel>,
      style: freezed == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyleModel?,
      textAlign: freezed == textAlign
          ? _self.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as TextAlign?,
      textDirection: freezed == textDirection
          ? _self.textDirection
          : textDirection // ignore: cast_nullable_to_non_nullable
              as TextDirection?,
      softWrap: freezed == softWrap
          ? _self.softWrap
          : softWrap // ignore: cast_nullable_to_non_nullable
              as bool?,
      overflow: freezed == overflow
          ? _self.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as TextOverflow?,
      textScaleFactor: freezed == textScaleFactor
          ? _self.textScaleFactor
          : textScaleFactor // ignore: cast_nullable_to_non_nullable
              as double?,
      maxLines: freezed == maxLines
          ? _self.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      semanticsLabel: freezed == semanticsLabel
          ? _self.semanticsLabel
          : semanticsLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      textWidthBasis: freezed == textWidthBasis
          ? _self.textWidthBasis
          : textWidthBasis // ignore: cast_nullable_to_non_nullable
              as TextWidthBasis?,
      selectionColor: freezed == selectionColor
          ? _self.selectionColor
          : selectionColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TextModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleModelCopyWith<$Res>? get style {
    if (_self.style == null) {
      return null;
    }

    return $TextStyleModelCopyWith<$Res>(_self.style!, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

/// @nodoc
mixin _$TextSpanModel {
  String get data;
  TextStyleModel? get style;
  TextAlign? get textAlign;
  TextDirection? get textDirection;
  bool? get softWrap;
  TextOverflow? get overflow;
  double? get textScaleFactor;
  int? get maxLines;
  String? get semanticsLabel;
  TextWidthBasis? get textWidthBasis;
  String? get selectionColor;

  /// Create a copy of TextSpanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextSpanModelCopyWith<TextSpanModel> get copyWith =>
      _$TextSpanModelCopyWithImpl<TextSpanModel>(
          this as TextSpanModel, _$identity);

  /// Serializes this TextSpanModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextSpanModel &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.textAlign, textAlign) ||
                other.textAlign == textAlign) &&
            (identical(other.textDirection, textDirection) ||
                other.textDirection == textDirection) &&
            (identical(other.softWrap, softWrap) ||
                other.softWrap == softWrap) &&
            (identical(other.overflow, overflow) ||
                other.overflow == overflow) &&
            (identical(other.textScaleFactor, textScaleFactor) ||
                other.textScaleFactor == textScaleFactor) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.semanticsLabel, semanticsLabel) ||
                other.semanticsLabel == semanticsLabel) &&
            (identical(other.textWidthBasis, textWidthBasis) ||
                other.textWidthBasis == textWidthBasis) &&
            (identical(other.selectionColor, selectionColor) ||
                other.selectionColor == selectionColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      data,
      style,
      textAlign,
      textDirection,
      softWrap,
      overflow,
      textScaleFactor,
      maxLines,
      semanticsLabel,
      textWidthBasis,
      selectionColor);

  @override
  String toString() {
    return 'TextSpanModel(data: $data, style: $style, textAlign: $textAlign, textDirection: $textDirection, softWrap: $softWrap, overflow: $overflow, textScaleFactor: $textScaleFactor, maxLines: $maxLines, semanticsLabel: $semanticsLabel, textWidthBasis: $textWidthBasis, selectionColor: $selectionColor)';
  }
}

/// @nodoc
abstract mixin class $TextSpanModelCopyWith<$Res> {
  factory $TextSpanModelCopyWith(
          TextSpanModel value, $Res Function(TextSpanModel) _then) =
      _$TextSpanModelCopyWithImpl;
  @useResult
  $Res call(
      {String data,
      TextStyleModel? style,
      TextAlign? textAlign,
      TextDirection? textDirection,
      bool? softWrap,
      TextOverflow? overflow,
      double? textScaleFactor,
      int? maxLines,
      String? semanticsLabel,
      TextWidthBasis? textWidthBasis,
      String? selectionColor});

  $TextStyleModelCopyWith<$Res>? get style;
}

/// @nodoc
class _$TextSpanModelCopyWithImpl<$Res>
    implements $TextSpanModelCopyWith<$Res> {
  _$TextSpanModelCopyWithImpl(this._self, this._then);

  final TextSpanModel _self;
  final $Res Function(TextSpanModel) _then;

  /// Create a copy of TextSpanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
    Object? style = freezed,
    Object? textAlign = freezed,
    Object? textDirection = freezed,
    Object? softWrap = freezed,
    Object? overflow = freezed,
    Object? textScaleFactor = freezed,
    Object? maxLines = freezed,
    Object? semanticsLabel = freezed,
    Object? textWidthBasis = freezed,
    Object? selectionColor = freezed,
  }) {
    return _then(_self.copyWith(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      style: freezed == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyleModel?,
      textAlign: freezed == textAlign
          ? _self.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as TextAlign?,
      textDirection: freezed == textDirection
          ? _self.textDirection
          : textDirection // ignore: cast_nullable_to_non_nullable
              as TextDirection?,
      softWrap: freezed == softWrap
          ? _self.softWrap
          : softWrap // ignore: cast_nullable_to_non_nullable
              as bool?,
      overflow: freezed == overflow
          ? _self.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as TextOverflow?,
      textScaleFactor: freezed == textScaleFactor
          ? _self.textScaleFactor
          : textScaleFactor // ignore: cast_nullable_to_non_nullable
              as double?,
      maxLines: freezed == maxLines
          ? _self.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      semanticsLabel: freezed == semanticsLabel
          ? _self.semanticsLabel
          : semanticsLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      textWidthBasis: freezed == textWidthBasis
          ? _self.textWidthBasis
          : textWidthBasis // ignore: cast_nullable_to_non_nullable
              as TextWidthBasis?,
      selectionColor: freezed == selectionColor
          ? _self.selectionColor
          : selectionColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TextSpanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleModelCopyWith<$Res>? get style {
    if (_self.style == null) {
      return null;
    }

    return $TextStyleModelCopyWith<$Res>(_self.style!, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _TextSpanModel implements TextSpanModel {
  const _TextSpanModel(
      {required this.data,
      this.style,
      this.textAlign,
      this.textDirection,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.selectionColor});
  factory _TextSpanModel.fromJson(Map<String, dynamic> json) =>
      _$TextSpanModelFromJson(json);

  @override
  final String data;
  @override
  final TextStyleModel? style;
  @override
  final TextAlign? textAlign;
  @override
  final TextDirection? textDirection;
  @override
  final bool? softWrap;
  @override
  final TextOverflow? overflow;
  @override
  final double? textScaleFactor;
  @override
  final int? maxLines;
  @override
  final String? semanticsLabel;
  @override
  final TextWidthBasis? textWidthBasis;
  @override
  final String? selectionColor;

  /// Create a copy of TextSpanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TextSpanModelCopyWith<_TextSpanModel> get copyWith =>
      __$TextSpanModelCopyWithImpl<_TextSpanModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TextSpanModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TextSpanModel &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.style, style) || other.style == style) &&
            (identical(other.textAlign, textAlign) ||
                other.textAlign == textAlign) &&
            (identical(other.textDirection, textDirection) ||
                other.textDirection == textDirection) &&
            (identical(other.softWrap, softWrap) ||
                other.softWrap == softWrap) &&
            (identical(other.overflow, overflow) ||
                other.overflow == overflow) &&
            (identical(other.textScaleFactor, textScaleFactor) ||
                other.textScaleFactor == textScaleFactor) &&
            (identical(other.maxLines, maxLines) ||
                other.maxLines == maxLines) &&
            (identical(other.semanticsLabel, semanticsLabel) ||
                other.semanticsLabel == semanticsLabel) &&
            (identical(other.textWidthBasis, textWidthBasis) ||
                other.textWidthBasis == textWidthBasis) &&
            (identical(other.selectionColor, selectionColor) ||
                other.selectionColor == selectionColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      data,
      style,
      textAlign,
      textDirection,
      softWrap,
      overflow,
      textScaleFactor,
      maxLines,
      semanticsLabel,
      textWidthBasis,
      selectionColor);

  @override
  String toString() {
    return 'TextSpanModel(data: $data, style: $style, textAlign: $textAlign, textDirection: $textDirection, softWrap: $softWrap, overflow: $overflow, textScaleFactor: $textScaleFactor, maxLines: $maxLines, semanticsLabel: $semanticsLabel, textWidthBasis: $textWidthBasis, selectionColor: $selectionColor)';
  }
}

/// @nodoc
abstract mixin class _$TextSpanModelCopyWith<$Res>
    implements $TextSpanModelCopyWith<$Res> {
  factory _$TextSpanModelCopyWith(
          _TextSpanModel value, $Res Function(_TextSpanModel) _then) =
      __$TextSpanModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String data,
      TextStyleModel? style,
      TextAlign? textAlign,
      TextDirection? textDirection,
      bool? softWrap,
      TextOverflow? overflow,
      double? textScaleFactor,
      int? maxLines,
      String? semanticsLabel,
      TextWidthBasis? textWidthBasis,
      String? selectionColor});

  @override
  $TextStyleModelCopyWith<$Res>? get style;
}

/// @nodoc
class __$TextSpanModelCopyWithImpl<$Res>
    implements _$TextSpanModelCopyWith<$Res> {
  __$TextSpanModelCopyWithImpl(this._self, this._then);

  final _TextSpanModel _self;
  final $Res Function(_TextSpanModel) _then;

  /// Create a copy of TextSpanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
    Object? style = freezed,
    Object? textAlign = freezed,
    Object? textDirection = freezed,
    Object? softWrap = freezed,
    Object? overflow = freezed,
    Object? textScaleFactor = freezed,
    Object? maxLines = freezed,
    Object? semanticsLabel = freezed,
    Object? textWidthBasis = freezed,
    Object? selectionColor = freezed,
  }) {
    return _then(_TextSpanModel(
      data: null == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      style: freezed == style
          ? _self.style
          : style // ignore: cast_nullable_to_non_nullable
              as TextStyleModel?,
      textAlign: freezed == textAlign
          ? _self.textAlign
          : textAlign // ignore: cast_nullable_to_non_nullable
              as TextAlign?,
      textDirection: freezed == textDirection
          ? _self.textDirection
          : textDirection // ignore: cast_nullable_to_non_nullable
              as TextDirection?,
      softWrap: freezed == softWrap
          ? _self.softWrap
          : softWrap // ignore: cast_nullable_to_non_nullable
              as bool?,
      overflow: freezed == overflow
          ? _self.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as TextOverflow?,
      textScaleFactor: freezed == textScaleFactor
          ? _self.textScaleFactor
          : textScaleFactor // ignore: cast_nullable_to_non_nullable
              as double?,
      maxLines: freezed == maxLines
          ? _self.maxLines
          : maxLines // ignore: cast_nullable_to_non_nullable
              as int?,
      semanticsLabel: freezed == semanticsLabel
          ? _self.semanticsLabel
          : semanticsLabel // ignore: cast_nullable_to_non_nullable
              as String?,
      textWidthBasis: freezed == textWidthBasis
          ? _self.textWidthBasis
          : textWidthBasis // ignore: cast_nullable_to_non_nullable
              as TextWidthBasis?,
      selectionColor: freezed == selectionColor
          ? _self.selectionColor
          : selectionColor // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of TextSpanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TextStyleModelCopyWith<$Res>? get style {
    if (_self.style == null) {
      return null;
    }

    return $TextStyleModelCopyWith<$Res>(_self.style!, (value) {
      return _then(_self.copyWith(style: value));
    });
  }
}

/// @nodoc
mixin _$TextStyleModel {
  @ColorConverter()
  Color? get color;
  double? get fontSize;

  /// Create a copy of TextStyleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TextStyleModelCopyWith<TextStyleModel> get copyWith =>
      _$TextStyleModelCopyWithImpl<TextStyleModel>(
          this as TextStyleModel, _$identity);

  /// Serializes this TextStyleModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TextStyleModel &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, color, fontSize);

  @override
  String toString() {
    return 'TextStyleModel(color: $color, fontSize: $fontSize)';
  }
}

/// @nodoc
abstract mixin class $TextStyleModelCopyWith<$Res> {
  factory $TextStyleModelCopyWith(
          TextStyleModel value, $Res Function(TextStyleModel) _then) =
      _$TextStyleModelCopyWithImpl;
  @useResult
  $Res call({@ColorConverter() Color? color, double? fontSize});
}

/// @nodoc
class _$TextStyleModelCopyWithImpl<$Res>
    implements $TextStyleModelCopyWith<$Res> {
  _$TextStyleModelCopyWithImpl(this._self, this._then);

  final TextStyleModel _self;
  final $Res Function(TextStyleModel) _then;

  /// Create a copy of TextStyleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? color = freezed,
    Object? fontSize = freezed,
  }) {
    return _then(_self.copyWith(
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      fontSize: freezed == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TextStyleModel implements TextStyleModel {
  const _TextStyleModel({@ColorConverter() this.color, this.fontSize});
  factory _TextStyleModel.fromJson(Map<String, dynamic> json) =>
      _$TextStyleModelFromJson(json);

  @override
  @ColorConverter()
  final Color? color;
  @override
  final double? fontSize;

  /// Create a copy of TextStyleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TextStyleModelCopyWith<_TextStyleModel> get copyWith =>
      __$TextStyleModelCopyWithImpl<_TextStyleModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TextStyleModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TextStyleModel &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, color, fontSize);

  @override
  String toString() {
    return 'TextStyleModel(color: $color, fontSize: $fontSize)';
  }
}

/// @nodoc
abstract mixin class _$TextStyleModelCopyWith<$Res>
    implements $TextStyleModelCopyWith<$Res> {
  factory _$TextStyleModelCopyWith(
          _TextStyleModel value, $Res Function(_TextStyleModel) _then) =
      __$TextStyleModelCopyWithImpl;
  @override
  @useResult
  $Res call({@ColorConverter() Color? color, double? fontSize});
}

/// @nodoc
class __$TextStyleModelCopyWithImpl<$Res>
    implements _$TextStyleModelCopyWith<$Res> {
  __$TextStyleModelCopyWithImpl(this._self, this._then);

  final _TextStyleModel _self;
  final $Res Function(_TextStyleModel) _then;

  /// Create a copy of TextStyleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? color = freezed,
    Object? fontSize = freezed,
  }) {
    return _then(_TextStyleModel(
      color: freezed == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      fontSize: freezed == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

// dart format on
