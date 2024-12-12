import 'dart:async';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class SurveillanceRepo {
  DatabaseReference ref = FirebaseDatabase.instance.ref('Image/SavedImage');

  static Image imageFromBase64(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Stream<ImageProvider> imageStream() {
    final StreamController<ImageProvider> controller =
        StreamController<ImageProvider>();

    // Subscribe to the Firebase stream
    final subscription = ref.onValue.listen(
      (DatabaseEvent event) {
        final String data = event.snapshot.value as String;
        final String base64String = data.split(',').last;

        Image image = imageFromBase64(base64String);
        controller.add(image.image);
      },
      onError: (error) {
        controller.addError(error); // Forward errors
      },
    );

    controller.onCancel = () {
      subscription.cancel();
    };
    return controller.stream;
  }
}
