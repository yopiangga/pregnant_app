part of 'widgets.dart';

class ListVideoWidget extends StatefulWidget {
  VideoModel video;
  ListVideoWidget({required this.video});

  @override
  State<ListVideoWidget> createState() => _ListVideoWidgetState();
}

class _ListVideoWidgetState extends State<ListVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => VideoDetailPage(
                      video: widget.video,
                    )));
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            AspectRatio(
                aspectRatio: 16 / 10,
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
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(widget.video.title,
                                style: darkTextFont.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600))),
                      ],
                    ),
                    SizedBox(
                      height: 2,
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
            ),
          ],
        ),
      ),
    );
  }
}
