part of 'widgets.dart';

class ButtonWidget extends StatefulWidget {
  String title;
  Function callback;
  bool active;

  ButtonWidget(
      {required this.title, required this.active, required this.callback});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isLoading
          ? SpinKitFadingCircle(
              color: mainColor,
            )
          : SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: widget.active
                        ? mainColor
                        : Colors.grey[200], // background
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)) // foreground
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
                    style: widget.active
                        ? whiteTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400)
                        : grayTextFont.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w400)),
              ),
            ),
    );
  }
}
