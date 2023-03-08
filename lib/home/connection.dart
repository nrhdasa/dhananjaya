import 'dart:convert';
import 'package:dhananjaya/connectivity.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../resources/utils.dart';

typedef ErrorHome<T> = Future<Either<ErrorResponse, T>>;

ErrorHome<Map<String, Map<String, double>>> getUserStats() async {
  var api = await Auth.getAPI();
  try {
    var url = Uri.https(api['domain'], 'api/method/dhananjaya.dhananjaya.api.general.user_stats');
    var response = await http.get(
      url,
      headers: {'Authorization': 'token ${api["key"]}:${api["secret"]}'},
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
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
      return right(donations);
    } else {
      print("here");
      print(jsonDecode(response.body)['exc_type']);
      print(jsonDecode(response.body)['exception']);
      return left(ErrorResponse(t: jsonDecode(response.body)['exc_type'], m: jsonDecode(response.body)['exception']));
    }
  } catch (e) {
    print(e.toString());
    return left(ErrorResponse(m: e.toString()));
  }
}
