
class Album {

  final int total_tracks;
  final String id;
  final List<dynamic> images;
  final dynamic tracks;
  final String name;



  Album({
    required this.total_tracks,
    required this.id,
    required this.images,
    required this.tracks,
    required this.name

  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      total_tracks: json['total_tracks'],
      id: json['id'],
      images: json['images'],
      tracks: json['tracks'] != null ? json['tracks'] : [],
      name: json['name']
    );
  }
  static List<Album> toListFromMap(List<dynamic> parsedListJson){
    List<Album> albums = List<Album>.from(parsedListJson.map((i) => Album.fromJson(i)));
    return albums;
  }

  Map<String, dynamic> toJson () {
    return {
      'total_tracks': this.total_tracks,
      'id' : this.id,
      'images' : this.images,
      'tracks' : this.tracks,
      'name' : this.name,
    };
  }

}