part of 'widgets.dart';

class DataAccountWidget extends StatefulWidget {
  UserModel user;
  DataAccountWidget({required this.user});

  @override
  State<DataAccountWidget> createState() => _DataAccountWidgetState();
}

class _DataAccountWidgetState extends State<DataAccountWidget> {
  TextEditingController idPersonalController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();

  bool isEmailValid = !false;

  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    idPersonalController.text = widget.user.identifier;
    nameController.text = widget.user.name;
    emailController.text = widget.user.email;
    whatsAppController.text = widget.user.phoneNumber;

    setState(() {});
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
          Text("Data Akun",
              style: darkTextFont.copyWith(
                  fontSize: 16, fontWeight: FontWeight.w600)),
          Container(
            margin: EdgeInsets.symmetric(vertical: 7),
            height: 1,
            color: accentColor[3],
          ),
          SizedBox(height: 5),
          LinierTextFieldWidget(
            enabled: false,
            controller: idPersonalController,
            title: "ID Pengenal",
            callback: (text) {},
          ),
          SizedBox(
            height: 15,
          ),
          LinierTextFieldWidget(
            enabled: false,
            controller: emailController,
            title: "Email",
            callback: (text) {},
          ),
          SizedBox(
            height: 15,
          ),
          LinierTextFieldWidget(
            controller: nameController,
            title: "Nama",
            callback: (text) {},
            enabled: true,
          ),
          SizedBox(
            height: 15,
          ),
          LinierTextFieldWidget(
            controller: whatsAppController,
            title: "WhatsApp",
            callback: (text) {},
            enabled: true,
          ),
          SizedBox(
            height: 25,
          ),
          ButtonSubmitWidget(
              title: "Update",
              callback: () async {
                String? token = await getToken();
                UserServices userServices = UserServices(token: token);
                var res = await userServices.editUser(
                  name: nameController.text,
                  whatsappNumber: widget.user.phoneNumber,
                );

                if (res.statusCode == 200) {
                  Flushbar(
                    duration: Duration(milliseconds: 4000),
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: Color(0xFF2DC653),
                    message: "Data akun berhasil diubah",
                  )..show(context);
                }
              })
        ],
      ),
    );
  }
}
