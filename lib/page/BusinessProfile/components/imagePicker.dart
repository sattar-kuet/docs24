// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ImagePickerComponent extends StatelessWidget {
  const ImagePickerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton.icon(
            onPressed: () async {
              String image = await businessLogoPickerAction(
                context,
                imageSource: ImageSource.camera,
              );
              Navigator.of(context).pop(image);
            },
            icon: Icon(
              Icons.camera,
              size: 20.sp,
            ),
            label: Text(
              "Camera",
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              String image = await businessLogoPickerAction(
                context,
                imageSource: ImageSource.gallery,
              );
              Navigator.of(context).pop(image);
            },
            icon: Icon(
              Icons.photo,
              size: 20.sp,
            ),
            label: Text(
              "Gallery",
              style: TextStyle(fontSize: 12.sp),
            ),
          )
        ],
      ),
    );
  }

  Future<String> businessLogoPickerAction(
    BuildContext context, {
    required ImageSource imageSource,
  }) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: imageSource);
    return base64Encode(await File(image!.path).readAsBytes());
  }
}
