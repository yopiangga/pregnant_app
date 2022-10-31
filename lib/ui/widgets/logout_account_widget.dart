part of 'widgets.dart';

class LogoutAccountWidget extends StatefulWidget {
  LogoutAccountWidget();

  @override
  State<LogoutAccountWidget> createState() => _LogoutAccountWidgetState();
}

class _LogoutAccountWidgetState extends State<LogoutAccountWidget> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      padding: EdgeInsets.all(defaultMargin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: accentColor[3].withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 10,
            offset: Offset(0, 7), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Lainnya",
              style: darkTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w600)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            height: 1,
            color: accentColor[3],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Ganti Akun", style: darkTextFont.copyWith(fontSize: 16)),
              GestureDetector(
                  onTap: () async {
                    await setToken("");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Icon(Icons.logout_outlined))
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Kebijakan Privasi",
                  style: darkTextFont.copyWith(fontSize: 16)),
              GestureDetector(
                  onTap: () async {
                    final Uri urlPrivacy =
                        Uri.parse('https://agileteknik.com/privacy');
                    await runUrl(urlPrivacy);
                  },
                  child: Icon(Icons.privacy_tip_outlined))
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Tentang Aplikasi",
                  style: darkTextFont.copyWith(fontSize: 16)),
              Text(versionApp, style: darkTextFont.copyWith(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Feedback Aplikasi",
                  style: darkTextFont.copyWith(fontSize: 16)),
              GestureDetector(
                  onTap: () async {
                    final Uri urlPrivacy =
                        Uri.parse('https://rebrand.ly/FeedbackATMobile');
                    await runUrl(urlPrivacy);
                  },
                  child: Icon(Icons.feedback_outlined))
            ],
          ),
        ],
      ),
    );
  }
}
