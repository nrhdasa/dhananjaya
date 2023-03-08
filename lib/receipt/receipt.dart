import 'package:json_annotation/json_annotation.dart';

part 'receipt.g.dart';

@JsonSerializable()
class DocField {
  late int idx;
  late String label;
  @JsonKey(name: 'fieldname')
  late String fieldName;
  @JsonKey(name: 'fieldtype')
  late String fieldType;
  late String? options;
  @JsonKey(name: 'default')
  late String? defaultValue;
  @JsonKey(fromJson: _boolFromInt)
  late bool reqd;

  static bool _boolFromInt(int val) => val == 1;

  DocField();

  factory DocField.fromJson(Map<String, dynamic> map) => _$DocFieldFromJson(map);
}
