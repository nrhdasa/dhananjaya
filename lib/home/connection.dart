import 'dart:convert';
import 'package:dhananjaya/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

getDonors(String search) async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/method/dhananjaya.dhananjaya.api.get_donor_data', {'searchquery': search});
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  // print(url);
  var donors = jsonDecode(response.body)['message'];
  // print(donors);
  return donors;
}
