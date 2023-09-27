


import 'package:image_picker/image_picker.dart';

class AppImagePicker {

  static Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }
}