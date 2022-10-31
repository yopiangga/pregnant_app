part of 'widgets.dart';

class LevelWidget extends StatefulWidget {
  UserProfileModel user;
  LevelWidget({required this.user});

  @override
  State<LevelWidget> createState() => _LevelWidgetState();
}

class _LevelWidgetState extends State<LevelWidget> {
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
          Row(
            children: [
              Text(widget.user?.experienceLevel?.name ?? "",
                  style: darkTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                children: [
                  Positioned(
                      child: Container(
                          decoration: BoxDecoration(
                              color: accentColor[0],
                              borderRadius: BorderRadius.circular(10)),
                          width: (MediaQuery.of(context).size.width -
                                  4 * defaultMargin) *
                              widget.user.nextExperienceLevelPercentage /
                              100
                          // height: 20,
                          )),
                  Align(
                    child: Text(
                      (widget.user?.experiencePoint).toString() +
                          " / " +
                          widget.user.nextExperienceLevel.targetPoint
                              .toString() +
                          " XP",
                      style: mainTextFont.copyWith(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
