part of 'widgets.dart';

class NormalVideoWidget extends StatefulWidget {
  VideoModel video;
  NormalVideoWidget({required this.video});

  @override
  State<NormalVideoWidget> createState() => _NormalVideoWidgetState();
}

class _NormalVideoWidgetState extends State<NormalVideoWidget> {
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
                  child: FadeInImage(
                    image: NetworkImage(
                      YoutubePlayerController.getThumbnail(
                        videoId: getIDVideo(widget.video.url),
                        quality: ThumbnailQuality.medium,
                      ),
                    ),
                    placeholder: AssetImage("assets/images/gray.png"),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/logo.png',
                          fit: BoxFit.cover);
                    },
                    fit: BoxFit.cover,
                  ),
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(widget.video.title,
                              maxLines: 2,
                              style: darkTextFont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600))),
                    ],
                  ),
                  Text(
                    widget.video?.description ?? "",
                    maxLines: 2,
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
