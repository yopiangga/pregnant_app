part of 'pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool load = true;
  UserModel? user;
  ConfigThreadModel? configThreadModel;
  List<ThreadModel> threads = [];
  List<SelectableThreadTopicModel> topics = [];
  TextEditingController titleController = TextEditingController();
  SelectableThreadTopicModel? topic;
  TextEditingController bodyController = TextEditingController();
  ToggleThreadServices? toggleThreadServices;
  bool createThread = false;
  ThreadServices? threadServices;
  SelectableThreadTopicServices? selectableThreadTopicServices;
  UserServices? userServices;

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
    userServices = UserServices(token: token);
    toggleThreadServices = ToggleThreadServices(token: token);
    selectableThreadTopicServices = SelectableThreadTopicServices(token: token);
    user = await userServices!.getUser();
    topics = await selectableThreadTopicServices!.getTopics();

    threadServices = ThreadServices(token: token);

    configThreadModel = await threadServices!.getThreads();
    threads = configThreadModel!.threads;

    if (this.mounted) {
      setState(() {
        load = false;
      });
    } // Your state change code goes here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            fetchData();
          });
        },
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.only(width: 2, color: accentColor[1]),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: accentColor[3].withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 7), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: load == true
                          ? SizedBox()
                          : FadeInImage(
                              image: NetworkImage(user!.profilePhotoPath),
                              placeholder: AssetImage("assets/images/user.png"),
                              imageErrorBuilder: (context, error, stackTrace) {
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
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        createThread = !createThread;
                      });
                    },
                    child: Container(
                      height: 45,
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      decoration: BoxDecoration(
                          // color: accentColor[3].withOpacity(0.2),
                          color: Color(0xFFF5F8FA),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Apa yang anda pikirkan?",
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
            createThread == false
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Judul",
                            style: darkTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        TextFieldWidget(
                            controller: titleController,
                            title: "Judul Postingan",
                            callback: (text) {}),
                        SizedBox(height: 20),
                        Text("Topik",
                            style: darkTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        load == true
                            ? SizedBox()
                            : Container(
                                height: 50,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: DropdownButtonWidget(
                                          topics: topics,
                                          title: "Topik",
                                          selected: topic == null
                                              ? topics[0]
                                              : topic!,
                                          action: (value) {
                                            setState(() {
                                              topic = value;
                                            });
                                          }),
                                    ),
                                  ],
                                )),
                        SizedBox(height: 20),
                        Text("Postingan",
                            style: darkTextFont.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        Container(
                          color: Color(0xFFF5F8FA),
                          margin: EdgeInsets.only(top: 0),
                          height: 200,
                          child: MarkdownFormField(
                              controller: bodyController,
                              enableToolBar: true,
                              emojiConvert: true,
                              autoCloseAfterSelectEmoji: false),
                        ),
                        Container(
                          height: 70,
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: ButtonWidget(
                                    title: "Sembunyikan",
                                    active: false,
                                    callback: () {
                                      setState(() {
                                        createThread = false;
                                        titleController.text = "";
                                        bodyController.text = "";
                                        topic = null;
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
                                      await threadServices?.postThread(
                                          title: titleController.text,
                                          body: bodyController.text,
                                          courseTypeId: topic!.id.toString());
                                      setState(() {
                                        createThread = false;
                                        titleController.text = "";
                                        bodyController.text = "";
                                        topic = null;
                                      });

                                      await FlushbarWidget(context,
                                          "Postingan berhasil dibuat!");

                                      fetchData();
                                    }),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            //   child: Row(
            //     children: [
            //       Container(
            //         padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.all(Radius.circular(5)),
            //             color: Colors.grey[200]),
            //         child: Text(
            //           "Tambah Filter",
            //           style: darkTextFont.copyWith(fontSize: 11),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            load == true || threads == null
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
                    children: threads
                        .map((e) => PostThreadWidget(
                            user: user,
                            thread: e,
                            toggleThreadServices: toggleThreadServices,
                            refresh: () {
                              fetchData();
                            }))
                        .toList()),
            SizedBox(
              height: 10,
            ),
            load == true
                ? SizedBox()
                : Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: ButtonSubmitWidget(
                      callback: () async {
                        final temp = await threadServices!.getThreads(
                            param: configThreadModel!.nextPageUrl! +
                                "&per_page=10");
                        setState(() {
                          threads += temp.threads;
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
    );
  }
}
