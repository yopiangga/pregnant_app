part of 'methods.dart';

Future<File> getImage() async {
  File imageFile;
  var image = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (image == null) return File("");

  imageFile = File(image.path);
  return imageFile;
}

Future<File> cropImage(File imageFile) async {
  CroppedFile? cropped = await ImageCropper().cropImage(
    sourcePath: imageFile.path,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 100,
  );

  File temp;

  if (cropped == null) {
    temp = imageFile;
  } else {
    temp = File(cropped.path);
  }

  return temp;
}
