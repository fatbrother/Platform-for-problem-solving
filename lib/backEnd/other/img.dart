import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImgManager {
  static final storage = FirebaseStorage.instance;

  // get the image from the database
  static Future<Image> getImage(String imgId) async {
    try {
      var image = await storage.ref(imgId).getData(1000000000);

      if (image == null) {
        throw Exception('No image found');
      }

      return Image.memory(image);
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
    // using the current time
    // to make sure the id is unique
    final String imgId = DateTime.now().toString(); 

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
