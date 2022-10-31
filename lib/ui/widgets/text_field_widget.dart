part of 'widgets.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String title;
  Function callback;

  TextFieldWidget(
      {required this.controller, required this.title, required this.callback});

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[600]!.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      child: TextField(
        onChanged: (text) {
          callback(text);
        },
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0),
          ),
          hintText: title,
        ),
      ),
    );
  }
}
