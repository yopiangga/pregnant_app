part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool load = true;
  late UserProfileModel? user;
  UserServices? userServices;

  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String? token = await getToken();
    userServices = UserServices(token: token);

    user = await userServices!.getUser();

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
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 20,
              ),
              load == true
                  ? Shimmer.fromColors(
                      baseColor: accentColor[4],
                      highlightColor: Colors.white,
                      period: Duration(milliseconds: 700),
                      child: Container(
                        height: 180,
                        color: Colors.grey,
                      ),
                    )
                  : PhotoAccountWidget(
                      user: user!,
                    ),
              SizedBox(
                height: 20,
              ),
              load == true
                  ? Shimmer.fromColors(
                      baseColor: accentColor[4],
                      highlightColor: Colors.white,
                      period: Duration(milliseconds: 700),
                      child: Container(
                        height: 100,
                        color: Colors.grey,
                      ),
                    )
                  : LevelWidget(
                      user: user!,
                    ),
              SizedBox(
                height: 20,
              ),
              load == true
                  ? Shimmer.fromColors(
                      baseColor: accentColor[4],
                      highlightColor: Colors.white,
                      period: Duration(milliseconds: 700),
                      child: Container(
                        height: 200,
                        color: Colors.grey,
                      ),
                    )
                  : DataAccountWidget(
                      user: user!,
                    ),
              SizedBox(
                height: 20,
              ),
              load == true
                  ? Shimmer.fromColors(
                      baseColor: accentColor[4],
                      highlightColor: Colors.white,
                      period: Duration(milliseconds: 700),
                      child: Container(
                        height: 150,
                        color: Colors.grey,
                      ),
                    )
                  : LogoutAccountWidget(),
              SizedBox(
                height: 90,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
