part of 'pages.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  bool load = true;
  late UserModel? user;
  late List<AnnouncementModel> announcements;
  UserServices? userServices;

  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String? token = await getToken();
    userServices = UserServices(token: token);

    user = await userServices!.getUser();
    announcements = await AnnouncementServices.getAnnouncement(token: token);

    if (this.mounted) {
      setState(() {
        load = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          fetchData();
        },
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 0,
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
                    children: announcements
                        .map(
                          (e) => PostAnnouncementWidget(announcement: e),
                        )
                        .toList(),
                  ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
