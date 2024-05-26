import 'package:flutter/material.dart';
import 'package:online_video_player_dart/utility/youtube_utils.dart';
import 'models/video_model.dart';
import 'services/video_service.dart';
import 'widgets/video_player_widget.dart';
import 'widgets/youtube_player_widget.dart';
// import 'utils/youtube_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Video Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<VideoModel>> _videos;
  bool _showVideos = false;

  @override
  void initState() {
    super.initState();
    _videos = VideoService().fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Video Player'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Video URL',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final url = _controller.text;
                if (url.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(url: url),
                    ),
                  );
                }
              },
              child: Text('Play Video'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showVideos = !_showVideos;
                });
              },
              child: Text(_showVideos ? 'Hide Pexels Videos' : 'Show Pexels Videos'),
            ),
            SizedBox(height: 20),
            _showVideos
                ? Expanded(
                    child: FutureBuilder<List<VideoModel>>(
                      future: _videos,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No videos found'));
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final video = snapshot.data![index];
                              return ListTile(
                                title: Text(video.title),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VideoPlayerScreen(url: video.url),
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatelessWidget {
  final String url;

  VideoPlayerScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    bool isYouTubeUrl = getYouTubeVideoId(url) != null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Center(
        child: isYouTubeUrl ? YoutubePlayerWidget(url: url) : VideoPlayerWidget(url: url),
      ),
    );
  }
}
