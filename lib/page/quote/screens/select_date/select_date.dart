import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../SendMail/Provider/sendMailProvider.dart';

Future<void> dateAlertDialog(BuildContext context) async {
  final nameController= TextEditingController();
  final addressController= TextEditingController();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: 350,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(30),
                        const Text('Date: ', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),),
                        DateTimeFormField(
                          decoration:  InputDecoration(
                            fillColor: Color.fromARGB(255, 224, 241, 255),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.black45),
                            errorStyle: TextStyle(color: Colors.redAccent),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                            suffixIcon: Icon(Icons.event_note),
                            hintText: 'Select Date',
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          autovalidateMode: AutovalidateMode.always,
                          onDateSelected: (DateTime value) {
                            final formattedDate =
                            DateFormat('d MMMM, y').format(value);
                            Provider.of<SendMailProvider>(context,
                                listen: false)
                                .setSelectedDate(formattedDate.toString());
                          },
                        ),
                        const Gap(10),
                        const Text('Expired date: ', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),),
                        TextField(
                          cursorColor: Colors.blue,
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Write expire date: ",
                            contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0), // Adjust the values as needed
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
                            ),
                          ),
                        ),
                        const Gap(10),
                        const Text('Reference: ', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),),
                        TextField(
                          cursorColor: Colors.blue,
                          maxLines: 3,
                          controller: addressController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.cancel,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
