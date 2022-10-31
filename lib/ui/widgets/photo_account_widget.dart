part of 'widgets.dart';

class PhotoAccountWidget extends StatefulWidget {
  UserModel user;
  PhotoAccountWidget({required this.user});

  @override
  State<PhotoAccountWidget> createState() => _PhotoAccountWidgetState();
}

class _PhotoAccountWidgetState extends State<PhotoAccountWidget> {
  File? imageEditingController;

  Future<File> action() async {
    dynamic img = await getImage();
    if (img != null) {
      dynamic image = await cropImage(img);
      if (image != null) {
        return image;
      }
    }
    return File("");
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
          Text("Foto Akun",
              style: darkTextFont.copyWith(
                  fontSize: 20, fontWeight: FontWeight.w600)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            height: 1,
            color: accentColor[3],
          ),
          Container(
            height: 140,
            width: double.infinity,
            child: Stack(
              children: [
                Align(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 5, color: Colors.white),
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
                        child: imageEditingController != null
                            ? FadeInImage(
                                image: FileImage(imageEditingController!),
                                placeholder:
                                    AssetImage("assets/images/user.png"),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset('assets/images/user.png',
                                      fit: BoxFit.cover);
                                },
                                fit: BoxFit.cover,
                              )
                            : FadeInImage(
                                image:
                                    NetworkImage(widget.user.profilePhotoPath),
                                placeholder:
                                    AssetImage("assets/images/user.png"),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset('assets/images/user.png',
                                      fit: BoxFit.cover);
                                },
                                fit: BoxFit.cover,
                              )),
                  ),
                ),
                // Positioned(
                //   top: 10,
                //   right: 20,
                //   left: 120,
                //   child: GestureDetector(
                //     onTap: () async {
                //       dynamic temp = await action();
                //       if (temp != null) {
                //         imageEditingController = temp;
                //         dynamic res = await UserServices.editUserPhoto(
                //             image: imageEditingController!.readAsBytesSync(),
                //             token: await getToken());
                //       }
                //       setState(() {});
                //     },
                //     child: Container(
                //       width: 35,
                //       height: 35,
                //       decoration: BoxDecoration(
                //           shape: BoxShape.circle, color: Colors.white),
                //       child: Icon(
                //         Icons.edit,
                //         color: accentColor[3],
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Text("Jenis file: png, jpg, jpeg. Ukuran maks: 150KB.",
          //     style: grayTextFont.copyWith(
          //         fontSize: 14, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
