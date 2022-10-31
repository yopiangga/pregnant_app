part of 'providers.dart';

class VideoProvider with ChangeNotifier {
  List<VideoModel> _videos = [];

  List<VideoModel> get videos => _videos;
}
