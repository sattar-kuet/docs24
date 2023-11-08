// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:docs24/utility/APIRoot.dart';
import 'package:docs24/utility/systemInfo.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class SignaturePad extends StatefulWidget {
  const SignaturePad({super.key});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Signature Pad"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final data =
                await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
            final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
            signatureAction(context, base64Encode(bytes!.buffer.asUint8List()));
          },
          child: const Icon(Icons.done),
        ),
        body: SizedBox(
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 90.w,
                width: 90.w,
                child: SfSignaturePad(
                  key: signatureGlobalKey,
                  minimumStrokeWidth: 1,
                  maximumStrokeWidth: 3,
                  strokeColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    signatureGlobalKey.currentState!.clear();
                  });
                },
                child: const Text(" Clear "),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signatureAction(BuildContext context, String imageData) async {
    setState(() {
      isLoading = true;
    });
    final response = await ApiRoot.request({
      "uid": SystemInfo.getUid,
      "signature": imageData,
    }, url: 'update_signature');

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });

      Navigator.of(context).pop();
    }
  }
}
