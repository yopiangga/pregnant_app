part of 'methods.dart';

Future<void> runUrl(url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
