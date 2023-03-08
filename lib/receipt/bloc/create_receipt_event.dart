part of 'create_receipt_bloc.dart';

enum FormAction { save, fetch }

class CreateReceiptEvent extends Equatable {
  final FormAction action;
  const CreateReceiptEvent({this.action = FormAction.fetch});

  @override
  List<Object?> get props => [action];
}


class CreateReceiptStarted extends CreateReceiptEvent{}

// class GetFields extends CreateReceiptEvent {
//   const GetFields({required super.action});
// }

class LinkTypeFieldChangeEvent extends CreateReceiptEvent {
  final DocField selectedField;
  const LinkTypeFieldChangeEvent({required this.selectedField});

  @override
  List<Object?> get props => [selectedField];
}
