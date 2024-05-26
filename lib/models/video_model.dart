class VideoModel {
  final String url;
  final String title;

  VideoModel({required this.url, required this.title});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      url: json['video_files'][0]['link'], // Assuming the first video file link
      title: json['user']['name'] ?? 'Untitled',
    );
  }
}
