import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_list_v2/constants.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';

class ImageInput extends StatefulWidget {
  ImageInput(
      {super.key,
      required this.onPickImage,
      this.backgroundColor,
      this.firstImage});

  final void Function(File) onPickImage;
  Color? backgroundColor;
  String? firstImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _pickedImage;

  final _imagePicker = ImagePicker();

  void _pickImage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text(
              'Where do you want to take your picture?',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton.icon(
                  onPressed: _getGalleryPicture,
                  icon: const Icon(FontAwesomeIcons.image),
                  label: const Text('Gallery')),
              TextButton.icon(
                  onPressed: _getCameraPicture,
                  icon: const Icon(FontAwesomeIcons.camera),
                  label: const Text('Camera')),
            ],
          );
        });
  }

  void _getCameraPicture() async {
    Navigator.pop(context);

    final selectedImage = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (selectedImage == null) {
      return;
    }

    setState(() {
      _pickedImage = File(selectedImage.path);
    });
    widget.onPickImage(_pickedImage!);
  }

  void _getGalleryPicture() async {
    Navigator.pop(context);

    final selectedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (selectedImage == null) {
      return;
    }

    setState(() {
      _pickedImage = File(selectedImage.path);
    });
    widget.onPickImage(_pickedImage!);
  }

  @override
  Widget build(BuildContext context) {
//ImageProvider<Object>? imageWidget= widget.firstImage!=null && _pickedImage==null ? Image.network(widget.firstImage!) : _pickedImage!=null ? Image.file(_pickedImage!):null;

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.backgroundColor != null ? 20.0 : 50),
      child: Center(
          child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: widget.backgroundColor ?? Colors.white,
            //display first image if exist
            backgroundImage: widget.firstImage != null && _pickedImage == null
                ? NetworkImage(widget.firstImage!)
                : _pickedImage != null
                    ? FileImage(_pickedImage!) as ImageProvider
                    : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: _pickImage,
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: kStartColor,
                child: Icon(
                  FontAwesomeIcons.camera,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
