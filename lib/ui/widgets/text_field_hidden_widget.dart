part of 'widgets.dart';

class TextFieldHiddenWidget extends StatefulWidget {
  TextEditingController controller;
  String title;
  Function callback;
  bool isObscure = true;

  TextFieldHiddenWidget(
      {required this.controller, required this.title, required this.callback});

  @override
  State<TextFieldHiddenWidget> createState() => _TextFieldHiddenWidgetState();
}

class _TextFieldHiddenWidgetState extends State<TextFieldHiddenWidget> {
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
          widget.callback(text);
        },
        controller: widget.controller,
        obscureText: widget.isObscure,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 0.0),
          ),
          hintText: widget.title,
          suffixIcon: IconButton(
            icon: Icon(
              widget.isObscure ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                widget.isObscure = !widget.isObscure;
              });
            },
          ),
        ),
      ),
    );
  }
}
