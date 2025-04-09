// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TextModel _$TextModelFromJson(Map<String, dynamic> json) => _TextModel(
      data: json['data'] as String,
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => TextSpanModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      style: json['style'] == null
          ? null
          : TextStyleModel.fromJson(json['style'] as Map<String, dynamic>),
      textAlign: $enumDecodeNullable(_$TextAlignEnumMap, json['textAlign']),
      textDirection:
          $enumDecodeNullable(_$TextDirectionEnumMap, json['textDirection']),
      softWrap: json['softWrap'] as bool?,
      overflow: $enumDecodeNullable(_$TextOverflowEnumMap, json['overflow']),
      textScaleFactor: (json['textScaleFactor'] as num?)?.toDouble(),
      maxLines: (json['maxLines'] as num?)?.toInt(),
      semanticsLabel: json['semanticsLabel'] as String?,
      textWidthBasis:
          $enumDecodeNullable(_$TextWidthBasisEnumMap, json['textWidthBasis']),
      selectionColor: json['selectionColor'] as String?,
    );

Map<String, dynamic> _$TextModelToJson(_TextModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'children': instance.children,
      'style': instance.style,
      'textAlign': _$TextAlignEnumMap[instance.textAlign],
      'textDirection': _$TextDirectionEnumMap[instance.textDirection],
      'softWrap': instance.softWrap,
      'overflow': _$TextOverflowEnumMap[instance.overflow],
      'textScaleFactor': instance.textScaleFactor,
      'maxLines': instance.maxLines,
      'semanticsLabel': instance.semanticsLabel,
      'textWidthBasis': _$TextWidthBasisEnumMap[instance.textWidthBasis],
      'selectionColor': instance.selectionColor,
    };

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};

const _$TextDirectionEnumMap = {
  TextDirection.rtl: 'rtl',
  TextDirection.ltr: 'ltr',
};

const _$TextOverflowEnumMap = {
  TextOverflow.clip: 'clip',
  TextOverflow.fade: 'fade',
  TextOverflow.ellipsis: 'ellipsis',
  TextOverflow.visible: 'visible',
};

const _$TextWidthBasisEnumMap = {
  TextWidthBasis.parent: 'parent',
  TextWidthBasis.longestLine: 'longestLine',
};

_TextSpanModel _$TextSpanModelFromJson(Map<String, dynamic> json) =>
    _TextSpanModel(
      data: json['data'] as String,
      style: json['style'] == null
          ? null
          : TextStyleModel.fromJson(json['style'] as Map<String, dynamic>),
      textAlign: $enumDecodeNullable(_$TextAlignEnumMap, json['textAlign']),
      textDirection:
          $enumDecodeNullable(_$TextDirectionEnumMap, json['textDirection']),
      softWrap: json['softWrap'] as bool?,
      overflow: $enumDecodeNullable(_$TextOverflowEnumMap, json['overflow']),
      textScaleFactor: (json['textScaleFactor'] as num?)?.toDouble(),
      maxLines: (json['maxLines'] as num?)?.toInt(),
      semanticsLabel: json['semanticsLabel'] as String?,
      textWidthBasis:
          $enumDecodeNullable(_$TextWidthBasisEnumMap, json['textWidthBasis']),
      selectionColor: json['selectionColor'] as String?,
    );

Map<String, dynamic> _$TextSpanModelToJson(_TextSpanModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'style': instance.style,
      'textAlign': _$TextAlignEnumMap[instance.textAlign],
      'textDirection': _$TextDirectionEnumMap[instance.textDirection],
      'softWrap': instance.softWrap,
      'overflow': _$TextOverflowEnumMap[instance.overflow],
      'textScaleFactor': instance.textScaleFactor,
      'maxLines': instance.maxLines,
      'semanticsLabel': instance.semanticsLabel,
      'textWidthBasis': _$TextWidthBasisEnumMap[instance.textWidthBasis],
      'selectionColor': instance.selectionColor,
    };

_TextStyleModel _$TextStyleModelFromJson(Map<String, dynamic> json) =>
    _TextStyleModel(
      color: const ColorConverter().fromJson(json['color']),
      fontSize: (json['fontSize'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TextStyleModelToJson(_TextStyleModel instance) =>
    <String, dynamic>{
      'color': const ColorConverter().toJson(instance.color),
      'fontSize': instance.fontSize,
    };
