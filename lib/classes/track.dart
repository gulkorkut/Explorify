
class Track {

  final String id;
  final String name;



  Track({
    required this.id,
    required this.name

  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        id: json['id'],
        name: json['name']
    );
  }
  static List<Track> toListFromMap(List<dynamic> parsedListJson){
    List<Track> tracks = List<Track>.from(parsedListJson.map((i) => Track.fromJson(i)));
    return tracks;
  }
  Map<String, dynamic> toJson () {
    return {
      'id' : this.id,
      'name' : this.name,
    };
  }

}