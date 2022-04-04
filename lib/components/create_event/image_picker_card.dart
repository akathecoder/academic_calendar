import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerCard extends StatefulWidget {
  ImagePickerCard({Key? key, this.image, required this.onImageUpdate})
      : super(key: key);

  File? image;
  final void Function(File? newImage) onImageUpdate;

  @override
  State<ImagePickerCard> createState() => _ImagePickerCardState();
}

class _ImagePickerCardState extends State<ImagePickerCard> {
  String imagePath = "";

  void handleImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? inputImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (inputImage != null) {
      setState(() {
        imagePath = inputImage.path;
        widget.image = File(imagePath);
      });

      widget.onImageUpdate(widget.image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        handleImage();
      },
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: getContent(),
      ),
    );
  }

  Widget getContent() {
    if (widget.image != null) {
      return Image.file(
        widget.image!,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        height: 200,
        width: double.infinity,
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8.0,
              spreadRadius: 2.0,
              offset: Offset(
                4.0,
                4.0,
              ),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              size: 36.0,
              color: Colors.grey.shade700,
            ),
            Text(
              "Add Image",
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      );
    }
  }
}
