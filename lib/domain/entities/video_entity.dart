class VideoEntity {
  final String id;
  final String name;
  final String youTubeKey;
  final DateTime publishedAt;

  VideoEntity({
    required this.id,
    required this.name,
    required this.youTubeKey,
    required this.publishedAt,
  });
}
