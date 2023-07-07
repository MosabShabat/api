import 'dart:io';

import 'package:api/api/model/ApiImageResplose.dart';
import 'package:api/controller/image_getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/controller/sudent_api_controller.dart';
import '../../utlis/helpers.dart';
import 'get_image.dart';

class AddImage extends StatefulWidget {
  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> with Helpers {
  late ImagePicker _picker;
  XFile? myImage;
  double? _progressValue = 0;

  @override
  void initState() {
    _picker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Images'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10,
            backgroundColor: Colors.green[200],
            color: Colors.green[700],
            value: _progressValue,
          ),
          Expanded(
              child: myImage != null
                  ? Image.file(File(myImage!.path))
                  : IconButton(
                      onPressed: () async => await _pickImage(),
                      icon: Icon(Icons.camera_alt),
                      iconSize: 70,
                      color: Colors.grey,
                    )),
          ElevatedButton.icon(
            onPressed: () async {
              if (myImage != null) {
                bool isS = await Get.find<ImageGetXController>()
                    .addImage(path: myImage!.path);
                Get.snackbar('message', 'FFFF',
                    backgroundColor: isS ? Colors.green : Colors.red);
              }
              //   Get.off(() => GetImage());
            },
            icon: Icon(Icons.cloud_upload),
            label: Text('UPLOAD'),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50)),
          )
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (imageFile != null) {
      setState(() => myImage = imageFile);
    }
  }
}
