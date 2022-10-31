part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isEmailValid = !false;
  bool isPasswordValid = !false;
  bool isSignIn = false;

  bool _isObscure = true;

  initState() {
    super.initState();
    emailController.text = "";
    passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<TokenProvider>(context).token;
    final userProfileProvider = Provider.of<UserProfileProvider>(context);
    UserProfileModel? user = userProfileProvider.user;

    return Scaffold(
        // appBar: AppBar(),
        body: Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                          fit: BoxFit.contain)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Email",
                  style: darkTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFieldWidget(
                  controller: emailController,
                  title: "Email",
                  callback: (text) {
                    setState(() {
                      isEmailValid = text.length >= 6;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Password",
                  style: darkTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFieldHiddenWidget(
                  controller: passwordController,
                  title: "Password",
                  callback: (text) {
                    setState(() {
                      isPasswordValid = text.length >= 6;
                    });
                  },
                ),
                SizedBox(
                  height: 32,
                ),
                ButtonSubmitWidget(
                    title: "LOGIN",
                    callback: isEmailValid && isPasswordValid
                        ? () async {
                            final prefs = await SharedPreferences.getInstance();
                            setState(() {
                              isSignIn = true;
                            });
                            var result = await AuthServices.login(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            );

                            if (result.statusCode == 200) {
                              token = jsonDecode(
                                  result.body.toString())['access_token'];

                              await prefs.setString('token', token);

                              UserServices userServices;
                              userServices = UserServices(token: token);

                              UserProfileModel? resultUser =
                                  await userServices.getUser();

                              userProfileProvider.setUser(resultUser);

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainPage(user: resultUser)));
                            } else {
                              Flushbar(
                                duration: Duration(milliseconds: 4000),
                                flushbarPosition: FlushbarPosition.TOP,
                                backgroundColor: Color(0xFFFF5C83),
                                message: "Email atau kata sandi salah!",
                              )..show(context);
                            }
                            setState(() {
                              isSignIn = false;
                            });
                          }
                        : () {}),
                SizedBox(
                  height: 32,
                ),
                Center(
                    child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: "Baru di sini?", style: darkTextFont),
                    TextSpan(
                      text: " Buat Akun",
                      style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final url =
                              Uri.parse('https://agileteknik.com/register');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            throw 'Could not lunch $url';
                          }
                        },
                    ),
                  ]),
                ))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
