import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dhananjaya/receipt/receipt.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '../../connectivity.dart';

part 'create_receipt_event.dart';
part 'create_receipt_state.dart';

class CreateReceiptBloc extends Bloc<CreateReceiptEvent, CreateReceiptState> {
  CreateReceiptBloc() : super(CreateReceiptState()) {
    on<CreateReceiptEvent>((event, emit) {
      getFields();
    });
  }
  getFields() async {
    var api = await Auth.getAPI();
    var url = Uri.https(api['domain'], 'api/method/dhananjaya.dhananjaya.api.donation_receipt.get_fields');
    var response = await http.get(
      url,
      headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
    );
    List fields = jsonDecode(response.body)['message'];
    var docFields = fields.map((e) => DocField.fromJson(e)).toList();
    docFields.sort(((a, b) => a.idx.compareTo(b.idx)));
    print(docFields);
    emit(CreateReceiptState(fields: docFields, status: FormStatus.initial));
  }
}

Future<List<Map<String, dynamic>>> getLinkOptions(String doctype, String query) async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/method/frappe.desk.search.search_link', {'doctype': doctype, 'txt': query});
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  print(response.body);
  var results = List<Map<String, dynamic>>.from(jsonDecode(response.body)['results']);
  return results;
}
