part of 'widgets.dart';

class ButtonSubmitWidget extends StatefulWidget {
  String title;
  Function callback;

  ButtonSubmitWidget({required this.title, required this.callback});

  @override
  State<ButtonSubmitWidget> createState() => _ButtonSubmitWidgetState();
}

class _ButtonSubmitWidgetState extends State<ButtonSubmitWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? SpinKitFadingCircle(
              color: mainColor,
            )
          : SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: mainColor, // background
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)) // foreground
                    ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await widget.callback();
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Text(widget.title,
                    style: whiteTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
    );
  }
}
