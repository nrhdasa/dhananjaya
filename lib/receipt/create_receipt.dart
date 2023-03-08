import 'package:dhananjaya/receipt/receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/create_receipt_bloc.dart';
import 'widgets.dart';

class CreateReceipt extends StatefulWidget {
  final String? id;
  const CreateReceipt({Key? key, required this.id}) : super(key: key);

  @override
  State<CreateReceipt> createState() => _CreateReceiptState();
}

class _CreateReceiptState extends State<CreateReceipt> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var texts = Theme.of(context).textTheme;
    var colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Donation Receipt"),
      ),
      body: BlocProvider(
        create: (context) => CreateReceiptBloc()..add(const CreateReceiptEvent(action: FormAction.fetch)),
        child: BlocBuilder<CreateReceiptBloc, CreateReceiptState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(child: Column(children: state.fields.map((e) => getInputWidget(e)).toList())),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getInputWidget(DocField field) {
    Widget widget;
    switch (field.fieldType) {
      case 'Data':
        widget = DataField(field: field);
        break;
      case 'Date':
        widget = DateField(field: field);
        break;
      case 'Check':
        widget = CheckField(field: field);
        break;
      case 'Link':
        widget = LinkField(
          field: field,
        );
        break;
      default:
        widget = Container();
    }
    return Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: widget);
  }
}
