
import 'dart:convert';

import 'package:explorify/classes/album.dart';
import 'package:explorify/classes/playlist.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authentication.dart';
import 'package:explorify/classes/track.dart';

class SpotifyApi {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String ?token;
  Map<String, String> ?headers;
  final Authentication auth = new Authentication();

  Future<bool> _validateToken() async {
    final SharedPreferences prefs = await _prefs;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime now = DateTime.now();
    DateTime tokenDateTime;
    String? tokenDateString = prefs.getString('token_date');

    if (tokenDateString == null) {
      //in case it is null we just give it a date that is already expired for safety
      tokenDateTime = DateTime(2021, 01, 01, 12, 0, 0);
    } else {
      tokenDateTime = dateFormat.parse(tokenDateString);
    }

    if (now.isAfter(tokenDateTime)) {
      return false;
    } else {
      return true;
    }
  }

  _setHeaders(String ?token) {
    headers = {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
  }

  Future<List<Album>> getNewReleases() async {// will eventually need a null safety since it can return 0 albums especially if country parameter is specified
    final SharedPreferences prefs = await _prefs;
    String query =
        "https://api.spotify.com/v1/browse/new-releases";

    bool isTokenValid = await _validateToken();

    if (isTokenValid) {
      _setHeaders(prefs.getString('access_token'));
      //print(prefs.getString('access_token'));

      Response response = await get(Uri.parse(query), headers: headers);
      print(response.body); // printing for testing purposes
      List<dynamic> parsedListJson = jsonDecode(response.body) as List;
      return Album.toListFromMap(parsedListJson);

    } else {
      try {
        await auth.requestAccessToken();
      } on AuthError catch (e) {
        throw AuthError(e.message);
      }
      _setHeaders(prefs.getString('access_token'));
      Response response = await get(Uri.parse(query), headers: headers);
      print(response.body);
      List<dynamic> parsedListJson = jsonDecode(response.body) as List;
      return Album.toListFromMap(parsedListJson);
    }
  }

  Future<Album> getAlbum(String id) async {
    final SharedPreferences prefs = await _prefs;
    String query =
        "https://api.spotify.com/v1/albums/$id";
    bool isTokenValid = await _validateToken();
    if (isTokenValid) {
      _setHeaders(prefs.getString('access_token'));
      Response response = await get(Uri.parse(query), headers: headers);
      print(response.body); // printing for testing purposes
      return Album.fromJson(jsonDecode(response.body));
    }
    else {
      try {
        await auth.requestAccessToken();
      } on AuthError catch (e) {
        throw AuthError(e.message);
      }
      _setHeaders(prefs.getString('access_token'));

      Response response = await get(Uri.parse(query), headers: headers);
      return Album.fromJson(jsonDecode(response.body));
    }
  }

  Future<List<Playlist>> getFeaturedPlaylists() async {
    final SharedPreferences prefs = await _prefs;
    String query =
        "https://api.spotify.com/v1/browse/featured-playlists";
    bool isTokenValid = await _validateToken();
    if (isTokenValid) {
      _setHeaders(prefs.getString('access_token'));
      Response response = await get(Uri.parse(query), headers: headers);
      print(response.body); // printing for testing purposes
      Map<String, dynamic> myMap = Map<String, dynamic>.from(jsonDecode(response.body));
      final validMap = json.decode(json.encode(myMap)) as Map<String, dynamic>;
      return Playlist.toListFromMap(validMap);
    }
    else{
      try {
        await auth.requestAccessToken();
      } on AuthError catch (e) {
        throw AuthError(e.message);
      }
      _setHeaders(prefs.getString('access_token'));

      Response response = await get(Uri.parse(query), headers: headers);
      print(response.body);
      Map<String, dynamic> myMap = Map<String, dynamic>.from(jsonDecode(response.body));
      final validMap = json.decode(json.encode(myMap)) as Map<String, dynamic>;
      return Playlist.toListFromMap(validMap);
    }
  }

  Future<Playlist> getPlaylist(playlist_id) async {
    final SharedPreferences prefs = await _prefs;
    String query =
        "https://api.spotify.com/v1/playlists/$playlist_id";
    bool isTokenValid = await _validateToken();
    if (isTokenValid) {
      _setHeaders(prefs.getString('access_token'));
      Response response = await get(Uri.parse(query), headers: headers);
      print(response.body); // printing for testing purposes
      return Playlist.fromJson(jsonDecode(response.body));
    }
    else {
      try {
        await auth.requestAccessToken();
      } on AuthError catch (e) {
        throw AuthError(e.message);
      }
      _setHeaders(prefs.getString('access_token'));

      Response response = await get(Uri.parse(query), headers: headers);
      return Playlist.fromJson(jsonDecode(response.body));
    }
  }

  Future<Track> getTrack(String id) async {
    final SharedPreferences prefs = await _prefs;
    String query =
        "https://api.spotify.com/v1/tracks/$id";
    bool isTokenValid = await _validateToken();
    if (isTokenValid) {
      _setHeaders(prefs.getString('access_token'));
      Response response = await get(Uri.parse(query), headers: headers);
      print(response.body); // printing for testing purposes
      return Track.fromJson(jsonDecode(response.body));
    }
    else {
      try {
        await auth.requestAccessToken();
      } on AuthError catch (e) {
        throw AuthError(e.message);
      }
      _setHeaders(prefs.getString('access_token'));

      Response response = await get(Uri.parse(query), headers: headers);
      return Track.fromJson(jsonDecode(response.body));
    }
  }

}