import 'package:flutter/material.dart';
import 'package:mailbox/page/SendMail/Provider/sendMailProvider.dart';
import 'package:sizer/sizer.dart';

class SelectContactWidget extends StatelessWidget {
  const SelectContactWidget({
    super.key,
    required this.stateAction,
    required this.index,
  });
  final SendMailProvider stateAction;
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 40.w,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name: ${stateAction.selectedContactList[index].name}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(
                "Company: ${stateAction.selectedContactList[index].companyName}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(
                "Phone: ${stateAction.selectedContactList[index].phone}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 10.sp,
              ),
              Text(
                "Email: ${stateAction.selectedContactList[index].email}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
