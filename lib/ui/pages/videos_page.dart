part of 'pages.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({Key? key}) : super(key: key);

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  bool load = true;
  bool init = true;

  ConfigVideoModel? configVideoModel;
  late List<VideoModel> videos;
  late List<CourseTypeModel> categorys;
  CourseTypeModel? category;
  VideoServices? videoServices;

  void initState() {
    super.initState();
    fetchData();
  }

  void dispose() {
    //...
    super.dispose();
    //...
  }

  void fetchData() async {
    String? token = await getToken();
    videoServices = VideoServices(token: token);

    configVideoModel = await videoServices!.getVideos();
    videos = configVideoModel!.videos;
    categorys = await CourseTypeServices.getCategorys(token: await getToken());

    if (this.mounted) {
      setState(() {
        load = false;
        init = false;
      });
    }
  }

  void fetchVideoByType(CourseTypeModel type) async {
    configVideoModel =
        await videoServices!.getVideosByType(type: type.id.toString());
    videos = configVideoModel!.videos;
    load = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          fetchData();
        },
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 15,
              ),
              init == false
                  ? Container(
                      height: 30,
                      child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: categorys.map((e) {
                            return Row(
                              children: [
                                SizedBox(width: e == categorys[0] ? 15 : 0),
                                e == categorys[0]
                                    ? ButtonWidget(
                                        title: "Semua",
                                        active: category == null ? true : false,
                                        callback: () {
                                          category = null;
                                          fetchData();
                                        },
                                      )
                                    : SizedBox(),
                                SizedBox(width: e == categorys[0] ? 8 : 0),
                                ButtonWidget(
                                  title: e.name,
                                  active: category == e ? true : false,
                                  callback: () {
                                    category = e;
                                    fetchVideoByType(e);
                                  },
                                ),
                                SizedBox(
                                    width: e == categorys[categorys.length - 1]
                                        ? 15
                                        : 8),
                              ],
                            );
                          }).toList()),
                    )
                  : Shimmer.fromColors(
                      baseColor: accentColor[4],
                      highlightColor: Colors.white,
                      period: Duration(milliseconds: 700),
                      child: Container(
                          height: 40,
                          child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: 8,
                              itemBuilder: (BuildContext ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Shimmer.fromColors(
                                    baseColor: accentColor[4],
                                    highlightColor: Colors.white,
                                    period: Duration(milliseconds: 700),
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                                ;
                              })),
                    ),
              SizedBox(
                height: 20,
              ),
              load == true
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: 8,
                      itemBuilder: (BuildContext ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: accentColor[4],
                            highlightColor: Colors.white,
                            period: Duration(milliseconds: 700),
                            child: Container(
                              height: 150,
                              color: Colors.grey,
                            ),
                          ),
                        );
                        ;
                      })
                  : Column(
                      children: videos
                          .map(
                            (e) => Column(
                              children: [
                                NormalVideoWidget(
                                  video: e,
                                ),
                                SizedBox(
                                    height: e == videos[videos.length - 1]
                                        ? 15
                                        : 10),
                              ],
                            ),
                          )
                          .toList(),
                    ),
              SizedBox(
                height: 10,
              ),
              load == true || configVideoModel!.nextPageUrl == null
                  ? SizedBox()
                  : Container(
                      height: 45,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: ButtonSubmitWidget(
                        callback: () async {
                          ConfigVideoModel temp;
                          temp = await videoServices!
                              .getVideos(param: configVideoModel!.nextPageUrl);

                          setState(() {
                            videos += temp.videos;
                          });
                        },
                        title: "Jelajahi lagi",
                      ),
                    ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
