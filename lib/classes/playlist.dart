class Playlist {

  final String id;
  final List<dynamic> images;
  final dynamic tracks;
  final List<dynamic> followers;
  final String name;



  Playlist({
    required this.id,
    required this.images,
    required this.tracks,
    required this.followers,
    required this.name,

  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
        id: json['id'],
        images: json['images'],
        tracks: json['tracks'] != null ? json['tracks'] : [],
        followers: json['followers'],
        name: json['name']
    );
  }
  static List<Playlist> toListFromMap(Map<String, dynamic> json){
    List<Playlist> playlists = <Playlist>[];
    json['playlists'].forEach((playlist) {
      playlists.add(Playlist(
        id: playlist['id'],
        images: playlist['images'],
        tracks: json['tracks'] != null ? json['tracks'] : [],
        followers: ['followers'],
        name: playlist['name'],
      ));
    });
    return playlists;
  }


}