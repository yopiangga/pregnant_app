part of 'pages.dart';

class VideoDetailPage extends StatefulWidget {
  VideoModel video;

  VideoDetailPage({required this.video});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  bool load = true;
  late List<VideoModel> videos;
  late List<CourseTypeModel> categorys;

  ConfigVideoModel? configVideoModel;
  VideoServices? videoServices;

  void initState() {
    super.initState();
    fetchData(widget.video.courseTypeId.toString());
  }

  void fetchData(String type) async {
    String? token = await getToken();
    videoServices = VideoServices(token: token);

    configVideoModel = await videoServices!.getVideosByType(type: type);
    videos = configVideoModel!.videos;
    categorys = await CourseTypeServices.getCategorys(token: token);
    load = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarWidget(src: "assets/images/logo.png", action: () {}),
      body: RefreshIndicator(
        onRefresh: () async {
          fetchData(widget.video.courseTypeId.toString());
        },
        child: ListView(
          children: [
            DetailVideoWidget(
              video: widget.video,
            ),
            Container(
              height: 1,
              color: accentColor[3],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: load == true
                  ? SizedBox()
                  : Text(
                      getCategoryByIndex(categorys, widget.video.courseTypeId)
                              ?.name ??
                          "-",
                      style: darkTextFont.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 10,
            ),
            load == true
                ? Center(
                    child: SpinKitFadingCircle(
                      color: mainColor,
                    ),
                  )
                : Column(
                    children: videos
                        .map(
                          (e) => Column(
                            children: [
                              ListVideoWidget(
                                video: e,
                              ),
                              SizedBox(
                                  height:
                                      e == videos[videos.length - 1] ? 15 : 10),
                            ],
                          ),
                        )
                        .toList(),
                  )
          ],
        ),
      ),
    );
  }
}
