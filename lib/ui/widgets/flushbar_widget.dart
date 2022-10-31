part of 'widgets.dart';

Flushbar FlushbarWidget(BuildContext context, String text) {
  return Flushbar(
    duration: Duration(milliseconds: 4000),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: Color(0xFF2DC653),
    message: text,
  )..show(context);
}
