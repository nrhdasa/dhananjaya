import 'dart:convert';
import 'package:dhananjaya/connectivity.dart';
import 'package:http/http.dart' as http;

getDonors(String search) async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/method/dhananjaya.dhananjaya.api.donors_search', {'searchquery': search});
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  // print(url);
  var donors = jsonDecode(response.body)['message'];
  // print(donors);
  return donors;
}

Future<Map<String, Map<String, double>>> getUserStats() async {
  var api = await Auth.getAPI();
  var url = Uri.https(api['domain'], 'api/method/dhananjaya.dhananjaya.api.user_stats');
  var response = await http.get(
    url,
    headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
  );
  var stats = jsonDecode(response.body)['message'];
  Map<String, Map<String, double>> donations = {};
  String month;
  for (var stat in stats) {
    month = stat['month'];
    donations.putIfAbsent(stat['company'], () => {});
    // {stat['month']:stat['amount']}
    donations[stat['company']]!.putIfAbsent(month, () => 0);
    double amt = donations[stat['company']]![month] as double;
    donations[stat['company']]![month] = stat['amount'] + amt;
  }
  return donations;
}
