// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocField _$DocFieldFromJson(Map<String, dynamic> json) => DocField()
  ..idx = json['idx'] as int
  ..label = json['label'] as String
  ..fieldName = json['fieldname'] as String
  ..fieldType = json['fieldtype'] as String
  ..options = json['options'] as String?
  ..defaultValue = json['default'] as String?
  ..reqd = DocField._boolFromInt(json['reqd'] as int);

Map<String, dynamic> _$DocFieldToJson(DocField instance) => <String, dynamic>{
      'idx': instance.idx,
      'label': instance.label,
      'fieldname': instance.fieldName,
      'fieldtype': instance.fieldType,
      'options': instance.options,
      'default': instance.defaultValue,
      'reqd': instance.reqd,
    };
