import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImagesService {
  ///Upload l'image sur Firebase storage et retourne sa download URL
  static Future<String> upload(String messageId, XFile image) async {
    //Créé la référence à l'image allant être uploadée
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child("images/$messageId/image.jpg");
    final file = File(image.path);
    //Uploade l'image
    await imageRef.putFile(file);
    //Récupère sa download URL
    return imageRef.getDownloadURL();
  }
}
