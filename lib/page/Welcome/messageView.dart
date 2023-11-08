import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Awaiting for admin approval.",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 15.sp,
              ),
        ),
      ),
    );
  }
}
