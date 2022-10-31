part of 'widgets.dart';

class TextFieldBlankWidget extends StatelessWidget {
  TextEditingController controller;
  String title;
  Function callback;
  Color fillColor;

  TextFieldBlankWidget(
      {required this.controller,
      required this.title,
      required this.callback,
      required this.fillColor});

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onChanged: (text) {
          callback(text);
        },
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: fillColor, width: 0.0),
          ),
          hintText: title,
        ),
        style: darkTextFont.copyWith(fontSize: 14),
      ),
    );
  }
}
