part of 'widgets.dart';

class PostAnnouncementWidget extends StatefulWidget {
  AnnouncementModel announcement;

  PostAnnouncementWidget({required this.announcement});

  @override
  State<PostAnnouncementWidget> createState() => _PostAnnouncementWidgetState();
}

class _PostAnnouncementWidgetState extends State<PostAnnouncementWidget> {
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: defaultMargin, vertical: defaultMargin),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: accentColor[3].withOpacity(0.6),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.announcement.title,
            style: mainTextFont.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 8,
          ),
          MarkdownBody(
            data: widget.announcement.body!,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
