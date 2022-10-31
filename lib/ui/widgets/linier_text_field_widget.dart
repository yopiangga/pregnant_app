part of 'widgets.dart';

class LinierTextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String title;
  Function callback;
  bool enabled;

  LinierTextFieldWidget(
      {required this.controller,
      required this.title,
      required this.callback,
      required this.enabled});

  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(width: 65, child: Text(title)),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                enabled: enabled,
                onChanged: (text) {},
                controller: controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor:
                      enabled == true ? accentColor[4] : Colors.grey[300],
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 0.0),
                  ),
                  hintText: title,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
