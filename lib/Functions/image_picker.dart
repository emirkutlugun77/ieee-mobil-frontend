import 'package:image_picker/image_picker.dart';

Future getImageFromGallery() async {
  ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future getImageFromCamera() async {
  ImagePicker _picker = ImagePicker();
  XFile? image = await _picker.pickImage(source: ImageSource.camera);
  return image;
}
