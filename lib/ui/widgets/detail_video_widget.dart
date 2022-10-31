part of 'widgets.dart';

class DetailVideoWidget extends StatefulWidget {
  VideoModel video;
  DetailVideoWidget({required this.video});

  @override
  State<DetailVideoWidget> createState() => _DetailVideoWidgetState();
}

class _DetailVideoWidgetState extends State<DetailVideoWidget> {
  bool autoPlay = false;

  void initState() {
    super.initState();
    fetchData();
  }

  dynamic controller;

  void fetchData() async {
    controller = YoutubePlayerController(
      initialVideoId: getIDVideo(widget.video.url),
      params: YoutubePlayerParams(
        startAt: Duration(seconds: 30),
        autoPlay: true,
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoDetailPage(
                      video: widget.video,
                    )));
      },
      child: Container(
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  child: YoutubePlayerIFrame(
                    controller: controller,
                    aspectRatio: 16 / 9,
                  ),
                )),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.video.title,
                      style: darkTextFont.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w600)),
                  Text(
                    widget.video?.description ?? "",
                    style: darkTextFont.copyWith(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
