String? getYouTubeVideoId(String url) {
  final Uri uri = Uri.parse(url);
  if (uri.host.contains('youtube.com')) {
    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'];
    }
  } else if (uri.host.contains('youtu.be')) {
    return uri.pathSegments.first;
  }
  return null;
}
