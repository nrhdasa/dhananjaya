part of 'create_receipt_bloc.dart';

enum FormStatus { initial, validating, saved, error }

class CreateReceiptState extends Equatable {
  final FormStatus status;
  final List<DocField> fields;
  final DocField? autoField;
  final List<String> options;
  CreateReceiptState({this.autoField, this.status = FormStatus.initial, this.fields = const <DocField>[], this.options = const <String>[]});

  @override
  List<Object> get props => [status, fields, options];

  CreateReceiptState copyWith({DocField? autoField, List<String>? options}) {
    return CreateReceiptState(autoField: autoField, options: options ?? []);
  }
}
