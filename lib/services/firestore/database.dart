import 'dart:convert';

import 'package:explorify/classes/album.dart';
import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.ref();

DatabaseReference saveAlbum(Album album) {
  var id = databaseReference.child('albums/').push();
  id.set(album.toJson());
  return id;
}

void updatePost(Album album, DatabaseReference id) {
  id.update(album.toJson());
}


Future<Album> getAlbumFromDatabase() async {

  DatabaseEvent event = await databaseReference.once();
  Album album = Album.fromJson(jsonDecode(jsonEncode(event.snapshot.value)));// I have to encode and decode the value of the snapshot because firebase database doesnt return a real json apparently
  return album;
}