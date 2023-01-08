import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ImgManager {
  static final storage = FirebaseStorage.instance;

  // get the image from the database with url
  static Future<String> getImageUrl(String imgId) async {
    try {
      return await storage.ref(imgId).getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  // upload the image to the database
  static Future<String> uploadImage() async {
    // using image picker
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      throw Exception('No image selected');
    }

    final File file = File(image.path);
    
    // create a image id
    Uuid uuid = const Uuid();
    String imgId;
    while (true) {
      imgId = uuid.v4();
      try {
        await storage.ref(imgId).getDownloadURL();
      } catch (e) {
        break;
      }
    }

    try {
      await storage.ref(imgId).putFile(file);
      return imgId;
    } catch (e) {
      rethrow;
    }
  }

  // delete the image from the database
  static Future<void> deleteImage(String imgId) async {
    try {
      await storage.ref(imgId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
