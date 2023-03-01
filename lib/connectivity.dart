import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
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
    var url = Uri.https(domain, 'api/method/dhananjaya.dhananjaya.api.get_user_profile');
    var response = await client.post(url, headers: {'Authorization': 'token $key:$secret'});
    prefs.setString("user", jsonDecode(response.body)['message']['user']);
    prefs.setString("full_name", jsonDecode(response.body)['message']['full_name']);
    print(jsonDecode(response.body)['message']['full_name']);
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
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

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

  static startAuthStream() {
    controller.sink.add(true);
    Timer.periodic(const Duration(seconds: 2), (timer) async {
      try {
        var api = await getAPI();
        if (api != null) {
          bool status = await checkAPI(api['domain'], api['key'], api['secret']);
          if (status) {
            controller.sink.add(true);
          } else {
            controller.sink.add(false);
          }
        } else {
          controller.sink.add(false);
        }
      } catch (e) {
        controller.sink.add(false);
      }
    });
  }
}
