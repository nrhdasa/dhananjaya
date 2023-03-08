import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Auth {
  static var controller = StreamController<bool>();
  static http.Client client = http.Client();

  static setAPI(String domain, String key, String secret) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("domain", domain);
    prefs.setString("key", key);
    prefs.setString("secret", secret);
    try {
      var url = Uri.https(domain, 'api/method/dhananjaya.dhananjaya.api.general.get_user_profile');
      var response = await client.post(url, headers: {'Authorization': 'token $key:$secret'});
      prefs.setString("user", jsonDecode(response.body)['message']['user']);
      prefs.setString("full_name", jsonDecode(response.body)['message']['full_name']);
    } catch (e) {
      print(e.toString());
    }
  }

  static getAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("domain")) {
      return {'domain': prefs.getString("domain"), 'key': prefs.getString("key"), 'secret': prefs.getString("secret"), 'user': prefs.getString("user"), 'full_name': prefs.getString("full_name")};
    } else {
      return null;
    }
  }

  static Future<bool> checkAPI(domain, key, secret) async {
    try {
      var url = Uri.https(domain, '/api/method/frappe.auth.get_logged_user');
      var response = await client.post(url, headers: {'Authorization': 'token $key:$secret'});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static discardAPI() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static closeStream() {
    client.close();
  }
}
