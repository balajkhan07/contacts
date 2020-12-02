import 'dart:typed_data';

import 'package:flutter/material.dart';

class ContactImage extends StatelessWidget {
  final Uint8List imageData;
  ContactImage(this.imageData);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.memory(
          imageData,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
