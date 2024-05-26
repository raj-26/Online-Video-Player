import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video_model.dart';

class VideoService {
  final String apiKey = 'Mq92zlmBs8FnrYliwqd0dj6HfIZnTOT369a8zjNI7jZ6C9dCfUs2DedO'; // Replace with your actual Pexels API key
  final String apiUrl = 'https://api.pexels.com/videos/popular';

  Future<List<VideoModel>> fetchVideos() async {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Authorization': apiKey,
    });

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['videos'];
      return body.map((dynamic item) => VideoModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }
}
