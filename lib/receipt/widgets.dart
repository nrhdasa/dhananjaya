import 'package:dhananjaya/receipt/receipt.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'bloc/create_receipt_bloc.dart';

String? reqdFieldValidation(String val) {
  return val.isEmpty ? "This is required." : null;
}

class DataField extends StatefulWidget {
  DocField field;
  DataField({Key? key, required this.field}) : super(key: key);

  @override
  State<DataField> createState() => _DataFieldState();
}

class _DataFieldState extends State<DataField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) {
        return (widget.field.reqd && val!.isEmpty) ? "This is required." : null;
      },
      enabled: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.field.label,
      ),
      onSaved: (newValue) {
        print(newValue);
      },
    );
  }
}

class DateField extends StatefulWidget {
  DocField field;
  DateField({Key? key, required this.field}) : super(key: key);

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.field.label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(30, 50), backgroundColor: Theme.of(context).colorScheme.tertiary, shape: StadiumBorder(side: BorderSide(color: Theme.of(context).colorScheme.secondary))),
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(context: context, initialDate: selectedDate, firstDate: DateTime(2010), lastDate: DateTime(2040));
                    if (dateTime != null) {
                      setState(() {
                        selectedDate = dateTime;
                      });
                    }
                  },
                  child: Icon(
                    Icons.date_range,
                    color: Theme.of(context).colorScheme.onTertiary,
                  )),
              const SizedBox(
                width: 10,
              ),
              const Text("|"),
              const SizedBox(
                width: 10,
              ),
              Text(
                DateFormat("dd MMM yyyy").format(selectedDate),
                style: const TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CheckField extends StatefulWidget {
  DocField field;
  CheckField({Key? key, required this.field}) : super(key: key);

  @override
  State<CheckField> createState() => _CheckFieldState();
}

class _CheckFieldState extends State<CheckField> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isChecked,
            onChanged: (val) {
              setState(() {
                isChecked = !isChecked;
              });
            }),
        const SizedBox(
          width: 20,
        ),
        Text(
          widget.field.label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}

// class SelectField extends StatefulWidget {
//   DocField field;
//   SelectField({Key? key, required this.field}) : super(key: key);

//   @override
//   State<SelectField> createState() => _SelectFieldState();
// }

// class _SelectFieldState extends State<SelectField> {
//   bool isChecked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//          Text(
//           widget.field.label,
//           style: const TextStyle(fontWeight: FontWeight.w600),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         DropdownButton(
//           items: items, onChanged: (val){})

//       ],
//     );
//   }
// }

class LinkField extends StatefulWidget {
  DocField field;
  LinkField({Key? key, required this.field}) : super(key: key);

  @override
  State<LinkField> createState() => _LinkFieldState();
}

class _LinkFieldState extends State<LinkField> {
  List<Map> options = [];
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Autocomplete<Map>(
            displayStringForOption: (option) {
              return option['value'];
            },
            fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                validator: (val) {
                  return (widget.field.reqd && val!.isEmpty) ? "This is required." : null;
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: widget.field.label,
                ),
                controller: textEditingController,
                focusNode: focusNode,
              );
            },
            optionsBuilder: (TextEditingValue textEditingValue) async {
              var options = await getLinkOptions(widget.field.options!, textEditingValue.text);
              return options.map((e) => e);
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Material(
                  elevation: 4,
                  child: ListView.separated(
                      itemBuilder: (contex, index) {
                        final Map option = options.elementAt(index) as Map;
                        return ListTile(
                          onTap: () {
                            return onSelected(option);
                          },
                          leading: Text(option['value']),
                          title: Text(option.containsKey("label") ? option['label'] : ""),
                          subtitle: Text(option['description']),
                        );
                      },
                      separatorBuilder: (contex, index) => Divider(),
                      itemCount: options.length));
            },
          )
        ],
      ),
    );
  }
}
