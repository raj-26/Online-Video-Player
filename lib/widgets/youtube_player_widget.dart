import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utility/youtube_utils.dart';
// import '../utils/youtube_utils.dart';

class YoutubePlayerWidget extends StatefulWidget {
  final String url;

  YoutubePlayerWidget({required this.url});

  @override
  _YoutubePlayerWidgetState createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = getYouTubeVideoId(widget.url);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller != null
        ? YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            onReady: () {
              _controller.play();
            },
          )
        : Center(child: CircularProgressIndicator());
  }
}
