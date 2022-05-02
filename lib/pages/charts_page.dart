import 'dart:io';
import 'package:explorify/classes/playlist.dart';
import 'package:explorify/services/spotify_API/spotify_api.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:explorify/widgets/charts_widget.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:explorify/services/spotify_API/authentication.dart';
import 'package:explorify/classes/album.dart';

import 'package:explorify/classes/track.dart';


class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  _ChartsPageState createState() => _ChartsPageState();
}




/*Future<http.Response> getFeaturedPlaylists() async {
  final response = await http.
    get(Uri.parse('https://api.spotify.com/v1/browse/featured-playlists'),
      headers: {
        'Authorization' : 'Bearer: ',

      },
  );
  if(response.statusCode == 200){
    print(jsonDecode(response.body));
    return jsonDecode(response.body);
  }
  else{
    throw Exception('failed to get data');
  }
}
*/
class _ChartsPageState extends State<ChartsPage> {
  //late Future<List<Playlist>> featuredPlaylists;
  late Future<List<Album>> newReleases;
  late Future<Playlist> featuredPlaylist;
  late Future<Album> someAlbum;
  late List<Track> trackList;
  final DatabaseReference ref = FirebaseDatabase.instance.ref("albums/");
  @override
  void initState() {
    super.initState();
    SpotifyApi api_handler = SpotifyApi();
    //featuredPlaylists = api_handler.getFeaturedPlaylists();
    //newReleases = api_handler.getNewReleases();
    //featuredPlaylist = api_handler.getPlaylist('37i9dQZF1DX0s5kDXi1oC5');//playlists don't work lol
    someAlbum = getAlbumFromDatabase();
  }

  Future<Album> getAlbumFromDatabase() async {

    DatabaseEvent event = await ref.once();
    Album album = Album.fromJson(jsonDecode(jsonEncode(event.snapshot.value)));// I have to encode and decode the value of the snapshot because firebase database doesnt return a real json apparently
    return album;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff121421),
        body: FutureBuilder<Album>(
          future: someAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //trackList = snapshot.data!.tracks['items'];
              return ListView.builder(
                itemCount: snapshot.data!.tracks['total'],
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ChartsWidget(
                        name: 'default name',
                      )
                    ],
                  );
                }
              );
            }
            else if (snapshot.hasError){
              print('${snapshot.error}');
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}



