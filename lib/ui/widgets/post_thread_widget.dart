part of 'widgets.dart';

class PostThreadWidget extends StatefulWidget {
  ThreadModel thread;
  UserModel? user;
  ToggleThreadServices? toggleThreadServices;
  Function refresh;

  PostThreadWidget(
      {required this.thread,
      required this.user,
      required this.toggleThreadServices,
      required this.refresh});

  @override
  State<PostThreadWidget> createState() => _PostThreadWidgetState();
}

class _PostThreadWidgetState extends State<PostThreadWidget> {
  bool load = false;
  TextEditingController replyController = TextEditingController(text: "");
  ThreadServices? threadServices;
  bool commandView = false;
  bool bodyView = false;
  bool like = false;
  bool star = false;
  bool createReply = false;

  @override
  Widget build(BuildContext context) {
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    UserProfileModel? user = userProfileProvider.user;

    return Column(
      children: [
        Container(
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor[3].withOpacity(0),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: load == true
                            ? SpinKitFadingCircle(
                                color: mainColor,
                              )
                            : FadeInImage(
                                image: NetworkImage(
                                    widget.thread.user.profilePhotoPath),
                                // image: AssetImage("assets/images/user.png"),
                                placeholder:
                                    AssetImage("assets/images/user.png"),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset('assets/images/user.png',
                                      fit: BoxFit.cover);
                                },
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.thread.user.name,
                          style: darkTextFont.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.thread.institution?.name ?? "Global",
                              style: darkTextFont.copyWith(
                                  fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.all_out,
                              size: 12,
                            ),
                            SizedBox(width: 5),
                            // Text(
                            //   DateFormat('kk:mm:ss EEE d MMM')
                            //       .format(widget.thread.createdAt),
                            //   style: darkTextFont.copyWith(fontSize: 10),
                            // ),
                            Text(
                              timeago.format(widget.thread.createdAt,
                                  locale: 'id'),
                              style: darkTextFont.copyWith(fontSize: 11),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  color: Colors.grey[200]),
                              child: Text(
                                widget.thread.courseType.name,
                                style: darkTextFont.copyWith(
                                    fontSize: 8, fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.thread.title,
                style: darkTextFont.copyWith(
                    fontSize: 14, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      bodyView = !bodyView;
                    });
                  },
                  child: true
                      ? MarkdownBody(
                          data: widget.thread.body,
                        )
                      : Column(
                          children: [
                            Container(
                              height: 150,
                              child: Markdown(
                                data: widget.thread.body,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Lihat Selengkapnya",
                                style: mainTextFont.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold))
                          ],
                        )),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  actionStatusByOther(
                      color: like == false ? accentColor[1] : accentColor[1],
                      icon: Icons.favorite,
                      value: widget.thread.threadLikesCount.toString(),
                      action: () async {
                        // if (like == true) {
                        //   setState(() {
                        //     widget.thread.threadLikesCount -= 1;
                        //     like = false;
                        //   });
                        // } else {
                        //   setState(() {
                        //     widget.thread.threadLikesCount += 1;
                        //     like = true;
                        //   });
                        // }

                        await widget.toggleThreadServices
                            ?.threadLike(idThread: widget.thread.id.toString());
                        await widget.refresh();
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  actionStatusByOther(
                      color: accentColor[2],
                      icon: Icons.comment,
                      value: widget.thread.repliesCount.toString(),
                      action: () {
                        setState(() {
                          commandView = !commandView;
                        });
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  widget.user!.experienceLevelId > 2 ||
                          widget.user!.id == widget.thread.userId
                      ? actionStatusByOther(
                          color:
                              star == false ? accentColor[1] : accentColor[0],
                          icon: Icons.star,
                          value: widget.thread.threadStarsCount.toString(),
                          action: () async {
                            if (star == true) {
                              setState(() {
                                widget.thread.threadStarsCount -= 1;
                                star = false;
                              });
                            } else {
                              setState(() {
                                widget.thread.threadStarsCount += 1;
                                star = true;
                              });
                            }

                            await widget.toggleThreadServices?.threadStar(
                                idThread: widget.thread.id.toString());
                          })
                      : SizedBox(),
                ],
              )
            ],
          ),
        ),
        commandView == false
            ? SizedBox()
            : Container(
                padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin, vertical: defaultMargin - 5),
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
                    Column(
                      children: widget.thread.replies!.reversed
                          .map(
                            (e) => Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 2, color: Colors.white),
                                      boxShadow: [
                                        BoxShadow(
                                          color: accentColor[3].withOpacity(0),
                                          spreadRadius: 3,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: load == true
                                          ? SpinKitFadingCircle(
                                              color: mainColor,
                                            )
                                          : FadeInImage(
                                              image: NetworkImage(
                                                  e.user.profilePhotoPath),
                                              // image: AssetImage(
                                              // "assets/images/user.png"),
                                              placeholder: AssetImage(
                                                  "assets/images/user.png"),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    'assets/images/user.png',
                                                    fit: BoxFit.cover);
                                              },
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.white),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        color:
                                            accentColor[2].withOpacity(0.05)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                e.user.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: darkTextFont.copyWith(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                timeago.format(e.createdAt,
                                                    locale: 'id'),
                                                style: darkTextFont.copyWith(
                                                    fontSize: 11),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await widget
                                                    .toggleThreadServices
                                                    ?.threadStarReply(
                                                        idThread: widget
                                                            .thread.id
                                                            .toString(),
                                                        idReply:
                                                            e.id.toString());
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    size: 18,
                                                    color: accentColor[2],
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    e.replyStarsCount
                                                        .toString(),
                                                    style:
                                                        darkTextFont.copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                accentColor[2]),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        MarkdownBody(
                                          data: e.body,
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: accentColor[3].withOpacity(0),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 5), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: load == true
                                  ? SpinKitFadingCircle(
                                      color: mainColor,
                                    )
                                  : FadeInImage(
                                      image: NetworkImage(widget.user == null
                                          ? ""
                                          : widget.user!.profilePhotoPath),
                                      // image: AssetImage("assets/images/user.png"),
                                      placeholder:
                                          AssetImage("assets/images/user.png"),
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/images/user.png',
                                            fit: BoxFit.cover);
                                      },
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: accentColor[2].withOpacity(0)),
                            child: createReply == false
                                ? GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        createReply = true;
                                      });
                                    },
                                    child: Container(
                                      height: 45,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: defaultMargin),
                                      decoration: BoxDecoration(
                                          // color: accentColor[3].withOpacity(0.2),
                                          color: Color(0xFFF5F8FA),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Tulis komentar ...",
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        color: Color(0xFFF5F8FA),
                                        margin: EdgeInsets.only(top: 0),
                                        height: 150,
                                        child: MarkdownFormField(
                                            controller: replyController,
                                            enableToolBar: true,
                                            emojiConvert: true,
                                            autoCloseAfterSelectEmoji: false),
                                      ),
                                      Container(
                                        height: 70,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: ButtonWidget(
                                                  title: "Sembunyikan",
                                                  active: false,
                                                  callback: () {
                                                    setState(() {
                                                      createReply = false;
                                                      replyController.text = "";
                                                    });
                                                  }),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: ButtonWidget(
                                                  title: "Post",
                                                  active: true,
                                                  callback: () async {
                                                    String? token =
                                                        await getToken();

                                                    threadServices =
                                                        ThreadServices(
                                                            token: token);
                                                    await threadServices
                                                        ?.postReplyThread(
                                                            body:
                                                                replyController
                                                                    .text,
                                                            threadId: widget
                                                                .thread.id
                                                                .toString());
                                                    setState(() {
                                                      createReply = false;
                                                      replyController.text = "";
                                                    });

                                                    await FlushbarWidget(
                                                        context,
                                                        "Komentar berhasil ditambah!");

                                                    widget.refresh();
                                                  }),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                          ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  GestureDetector actionStatusByOther(
      {required Color color,
      required IconData icon,
      required String value,
      required Function action}) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 18,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              value,
              style: darkTextFont.copyWith(
                  fontSize: 14, fontWeight: FontWeight.w600, color: color),
            )
          ],
        ),
      ),
    );
  }
}
