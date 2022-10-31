part of 'pages.dart';

class MainPage extends StatefulWidget {
  UserProfileModel? user;

  MainPage({required this.user});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late int bottomNavBarIndex;
  late PageController pageController;

  int activeMenu = 0;
  late TabController _tabController;

  bool loading = false;
  bool isGetData = true;

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published! Clicked');
    });

    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(src: "assets/images/logo.png", action: () {}),
      body: Stack(
        children: [
          Container(
            color: accentColor[0],
          ),
          SafeArea(
            child: Container(
              color: Color(0xFFF6F7F9),
            ),
          ),
          TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              HomePage(),
              VideosPage(),
              AnnouncementPage(),
              ProfilePage()
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color(0xff1A2E35).withOpacity(0.05),
                spreadRadius: 3,
                blurRadius: 12,
                offset: Offset(3, 0), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            BottomNavBar(icon: Icons.home, index: 0),
            BottomNavBar(icon: Icons.ondemand_video, index: 1),
            BottomNavBar(icon: Icons.announcement, index: 2),
            BottomNavBar(icon: Icons.person, index: 3),
          ],
        ),
      ),
    );
  }

  GestureDetector BottomNavBar({IconData icon = Icons.home, int index = 0}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          activeMenu = index;
          _tabController.animateTo(index);
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              color: index == activeMenu
                  ? Color(0xff4265D6).withOpacity(0.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10)),
          child: Container(
            child: Icon(icon,
                size: 28,
                color:
                    index == activeMenu ? Color(0xff4265D6) : accentColor[3]),
          ),
        ),
      ),
    );
  }
}
