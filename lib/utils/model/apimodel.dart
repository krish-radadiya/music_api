class Apimodel {
  int? id;
  String title;
  String album;
  String artist;
  String genre;
  String source;
  String image;
  int trackNumber;
  int totalTrackCount;
  int duration;
  String site;

  Apimodel({
    required this.title,
    required this.album,
    required this.artist,
    required this.genre,
    required this.source,
    required this.image,
    required this.duration,
    required this.totalTrackCount,
    required this.trackNumber,
    required this.site,
    this.id,
  });

  factory Apimodel.fromapi({required Map<String, dynamic> data}) {
    return Apimodel(
      title: data["title"],
      album: data["album"],
      artist: data["artist"],
      genre: data["genre"],
      source: data["source"],
      image: data["image"],
      duration: data["duration"],
      totalTrackCount: data["totalTrackCount"],
      trackNumber: data["trackNumber"],
      site: data["site"],
    );
  }
}
