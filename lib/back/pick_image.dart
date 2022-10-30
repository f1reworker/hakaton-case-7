// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';

Future<XFile?> imagePicker() async {
  ImagePicker picker = ImagePicker();
  XFile? images = await picker.pickImage(source: ImageSource.gallery);
  return images;
}
