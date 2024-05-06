import 'package:flutter/material.dart';
import 'package:gap/gap.dart';


Future<void> companyInfoAlertDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Stack(
              children: [
                Column(
                  children: [

                  ],
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.cancel, size: 30,),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
