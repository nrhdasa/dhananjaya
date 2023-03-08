import 'dart:convert';
import 'package:dhananjaya/connectivity.dart';
import 'package:http/http.dart' as http;

Future<dynamic> getDonations(String donorId) async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/resource/Donation Receipt', {'fields': '["*"]', 'filters': '[["donor", "=", "$donorId"]]', 'order_by': 'receipt_date desc'});
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  return jsonDecode(response.body)['data'];
}

Future<Map<String, dynamic>> getDonorStats(String donorId) async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/method/dhananjaya.dhananjaya.api.donor.donor_stats', {'donor': donorId});
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  return jsonDecode(response.body)['message'];
}
