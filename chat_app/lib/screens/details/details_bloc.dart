import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailsBloc {
  final ImagePicker _picker = ImagePicker();

  StreamController<Uint8List?> imageBytesStream =
      StreamController<Uint8List?>.broadcast();

  ValueNotifier<bool> isDarkNotifier = ValueNotifier<bool>(false);

  StreamController<bool> isDarkStream = StreamController<bool>.broadcast();

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List pickedImageBytes = await pickedFile.readAsBytes();

      imageBytesStream.sink.add(pickedImageBytes);
    }
  }

  String getCurrentDateTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('hh:mm aa');
    final String formatted = formatter.format(now);
    return formatted;
  }
}
