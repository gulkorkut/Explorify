import 'dart:core';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {

  final Map<String, String> body = {"grant_type": "client_credentials"};
  static Map<String, String>? headers;
  final String client_id = '52e70f203f99442c99026b4f04ef40fe';
  final String client_secret = '9785789bd4fd4bb1a09485207015797a';
  final String token_url = "https://accounts.spotify.com/api/token";
  final String redirect_uri = 'https://localhost:8888/callback';
  final String scopes = 'user-read-private user-follow-read user-library-read playlist-read-collaborative user-read-email playlist-read-private user-top-read';
  final String authorize_url = 'https://accounts.spotify.com/authorize';
  final String encoded_secret = 'NTJlNzBmMjAzZjk5NDQyYzk5MDI2YjRmMDRlZjQwZmU6OTc4NTc4OWJkNGZkNGJiMWEwOTQ4NTIwNzAxNTc5N2E=';
  final String auth_code = 'AQB3Va-D-06EWRzZPA-rQUbRGFINEVQJTVPphbPn7XXAPSzDHpE6wOnZ8wI7J2GceKKQWte-MD28jiZIp7mW76UgiHQ2dTLt6Ah5Xd7OGwkUxiOvEDZTQk-CJXjF0F3607xKEiiE48SGQudVarzL_RInF1kFp9AuBes9QGOz5IajiVzs3FFnvXF_83dwDnORCCW4dgyxYdbffHcCc-tSOd3XTFG1n_AtpaXV71o8tCZWRrurYXkxxdVXdpLX9ApzLRFNhpsoIpsYOIbVnPGZinwqAL3LjRThsL2TlpiWu0tQ6FE4B3COr6B1HQwjSHW9M7qQXYAv9u2yPPqsDkZQhwW6ycJlMREAIx7vL-a7-g';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // some of these values will be hidden eventually.

  Future getAuthCode() async {
    var url = authorize_url;
    url += '?client_id=' + client_id;
    url += '&response_type=code';
    url += '&redirect_uri=' + Uri.encodeFull(redirect_uri);
    url += '&scope=' + Uri.encodeFull(scopes);
    /*
    if(await canLaunch(url)){
      await launch(url);
    }
    else {
      throw 'cant lauch lol $url';
    }
    */
    print(url);
    //print(Uri.parse(url));
    //http.Response response = await http.get(Uri.parse(url));
    //var code = jsonDecode(response.body);
    //print(code);

  }
  Future _setTokenExpirationDate() async {
    final SharedPreferences prefs = await _prefs;
    DateTime _hourFromNow = new DateTime.now();
    _hourFromNow = _hourFromNow.add(new Duration(minutes: 55));

    String dateString = _hourFromNow.toString();
    prefs.setString('token_date', dateString);
  }


  Future requestAccessToken() async {
    final SharedPreferences prefs = await _prefs;
    var url = token_url;
    url += '?grant_type=authorization_code';
    url += '&code='+Uri.encodeFull(auth_code);
    url += '&redirect_uri='+ Uri.encodeFull(redirect_uri);
    Map<String, String> headers = {
      "Authorization": "Basic "+ encoded_secret,
      "Content-Type": "application/x-www-form-urlencoded",
    };
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
        encoding: Encoding.getByName("utf-8"),
      );
      Map<dynamic, dynamic> map = jsonDecode(response.body);
      await _setTokenExpirationDate();
      prefs.setString('access_token', map['access_token']);

    }
    on SocketException catch (e) {
      debugPrint(e.message + ', ' + e.osError.toString());
      throw AuthError(e.message);
    }
  }

}

class AuthError extends Error {
  final String message;
  AuthError(this.message);
}