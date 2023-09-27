import 'package:chat_app/core/contants/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

 class FirebaseStorageUploader {



 static  Future<String?> uploadFile(XFile? file) async {
    String? fileUrl;
    if (file == null) {
      return null;
    }
    UploadTask uploadTask;
    final photoName = DateTime.now().toIso8601String();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(AppConstants.photosPath)
        .child('/$photoName.jpg');
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    uploadTask = ref.putFile(io.File(file.path), metadata);
    await uploadTask.whenComplete(() async {
      fileUrl = await ref.getDownloadURL();
    });
    return fileUrl;
  }
}
