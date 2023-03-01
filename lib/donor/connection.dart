import 'dart:convert';
import 'package:dhananjaya/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

getDonorDetails(String id) async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/resource/Donor/$id');
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  print(response.body);
  // // print(url);
  return jsonDecode(response.body)['data'];
  // // print(donors);
  // return donors;
}
