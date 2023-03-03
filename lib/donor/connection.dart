import 'dart:convert';
import 'package:dhananjaya/connectivity.dart';
import 'package:http/http.dart' as http;

getDonorDetails(String id) async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/resource/Donor/$id');
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  // print(response.body);
  // // print(url);
  return jsonDecode(response.body)['data'];
  // // print(donors);
  // return donors;
}

Future<dynamic> getDonations(String donorId) async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/resource/Donation Receipt', {'fields': '["*"]', 'filters': '[["donor", "=", "$donorId"]]', 'order_by': 'receipt_date desc'});
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  return jsonDecode(response.body)['data'];
  // // print(donors);
  // return donors;
}

Future<Map<String, dynamic>> getDonorStats(String donorId) async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/method/dhananjaya.dhananjaya.api.donor_stats', {'donor': donorId});
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  return jsonDecode(response.body)['message'];
}

updateLongLatAddress(String addressId, double lng, double lat) async {
  var api = await Auth.getAPI();
  Uri url = Uri.https(
    api['domain'],
    '/api/resource/Donor Address/$addressId',
  );
  var response = await http.put(url, headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'}, body: {'longitude': lng.toString(), 'latitude': lat.toString()});
}
