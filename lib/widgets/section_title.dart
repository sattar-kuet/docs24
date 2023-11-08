import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'body_text.dart';

class SecationTitle extends StatelessWidget {
  const SecationTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.w),
      child: Container(
        width: 100.w,
        height: 8.w,
        alignment: Alignment.centerLeft,
        color: Colors.grey.shade300,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.5.w,
          ),
          child: BodyText(
            text: title,
            fontsize: 12,
          ),
        ),
      ),
    );
  }
}
