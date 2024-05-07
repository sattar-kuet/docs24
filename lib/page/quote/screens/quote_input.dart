import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mailbox/page/quote/screens/select_date/select_date.dart';
import 'package:provider/provider.dart';

import '../../../widgets/text_button.dart';
import '../../SendMail/Provider/sendMailProvider.dart';
class QuoteInput extends StatefulWidget {
  const QuoteInput({super.key});

  @override
  State<QuoteInput> createState() => _QuoteInputState();
}

class _QuoteInputState extends State<QuoteInput> {
  final compoanyNameController= TextEditingController();
  final comopanyAddressController= TextEditingController();
  final quoteNameController= TextEditingController();
  final quoteAddressController= TextEditingController();
  final expireDateController= TextEditingController();
  final referenceController= TextEditingController();
  final abnacnController= TextEditingController();
  final descriptionController= TextEditingController();
  final quantityController= TextEditingController();
  final unitPriceController= TextEditingController();
  final gstController= TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  int _selectedValue = 1;
  String selec_vlaue="ABN";

  Future<void> getImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
                child: const Padding(
                  padding: EdgeInsets.only(left: 17.0, top: 3, bottom: 3),
                  child: Text('Company Info', style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                  ),),
                ),
              ),
              Padding(
               padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 17),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Column(
                     children: [
                       SizedBox(
                         width: MediaQuery.of(context).size.width/2,
                         child: TextField(
                           cursorColor: Colors.blue,
                           controller: compoanyNameController,
                           decoration: const InputDecoration(
                             hintText: "Write Company Name",
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.blue),
                             ),
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.blue),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(
                         width: MediaQuery.of(context).size.width/2,
                         child: TextField(
                           cursorColor: Colors.blue,
                           controller: comopanyAddressController,
                           decoration: const InputDecoration(
                             hintText: "Write Company Address",
                             enabledBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.blue),
                             ),
                             focusedBorder: UnderlineInputBorder(
                               borderSide: BorderSide(color: Colors.blue),
                             ),
                           ),
                         ),
                       ),
                     ],
                   ),

                   SizedBox(
                     child: GestureDetector(
                       onTap: getImage,
                       child: Container(
                         width: 60,
                         height: 60,
                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.transparent),
                           borderRadius: BorderRadius.circular(30),
                         ),
                         child: _image == null
                             ? ClipRRect(
                           borderRadius: BorderRadius.circular(100),
                             child: const Image(image: AssetImage("assets/logo.jpeg"),fit: BoxFit.fill,))
                             : ClipRRect(
                             borderRadius: BorderRadius.circular(100),
                             child: Image.file(File(_image!.path), fit: BoxFit.fitWidth,))
                       ),
                     ),
                   ),
                 ],
               ),
             ),
              const Gap(20),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade200,
                child: const Padding(
                  padding: EdgeInsets.only(left: 17.0, top: 3, bottom: 3),
                  child: Text('Quote To', style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600
                  ),),
                ),
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:5, horizontal: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Name', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                    TextField(
                      cursorColor: Colors.blue,
                      controller: quoteNameController,
                      decoration: InputDecoration(
                        hintText: "Client Name",
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
                    const Text('Address', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                    TextField(
                      cursorColor: Colors.blue,
                      maxLines: 3,
                      controller: quoteAddressController,
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        fillColor: Color.fromARGB(255, 224, 241, 255),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        border: OutlineInputBorder(
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
                    const Text('Expired date', style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                    TextField(
                      cursorColor: Colors.blue,
                      controller: expireDateController,
                      decoration: InputDecoration(
                        hintText: "Write expire date in days ",
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
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                    TextField(
                      cursorColor: Colors.blue,
                      maxLines: 3,
                      controller: referenceController,
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio<int>(
                      fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                      value: 1,
                      groupValue: _selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedValue = value!;
                          selec_vlaue="ABN";
                        });
                      },
                    ),
                    const Text('ABN'),
                    Radio<int>(
                      fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                      value: 2,
                      groupValue: _selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedValue = value!;
                          selec_vlaue="ACN";
                        });
                      },
                    ),
                    const Text('ACN'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${selec_vlaue} Number', style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),),
                    TextField(
                      cursorColor: Colors.blue,
                      controller: quoteNameController,
                      decoration: InputDecoration(
                        hintText: "${selec_vlaue} Number",
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
                    const Gap(30),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade600,
                          width: 1
                        ),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                const Text("Select Item",style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),),
                                const Gap(10),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade600,
                                        width: 1
                                      )
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton2<String>(
                                        isExpanded: true,
                                        hint: Text(
                                          'Select Item',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                        ),
                                        items: items
                                            .map((String item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ))
                                            .toList(),
                                        value: selectedValue,
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedValue = value;
                                          });
                                        },
                                        buttonStyleData: const ButtonStyleData(
                                          padding: EdgeInsets.symmetric(horizontal: 16),
                                          height: 40,
                                          width: 140,
                                        ),
                                        menuItemStyleData: const MenuItemStyleData(
                                          height: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/4,
                                  child: const Text("Description: ",style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ),
                                const Gap(10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  child: TextField(
                                    cursorColor: Colors.blue,
                                    controller: descriptionController,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/4,
                                  child: const Text("Quantity: ",style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ),
                                const Gap(10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  child: TextField(
                                    cursorColor: Colors.blue,
                                    controller: quantityController,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/4,
                                  child: const Text("Unit Price: ",style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ),
                                const Gap(10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  child: TextField(
                                    cursorColor: Colors.blue,
                                    controller: unitPriceController,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/4,
                                  child: const Text("GST: ",style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500
                                  ),),
                                ),
                                const Gap(10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2.5,
                                  child: TextField(
                                    cursorColor: Colors.blue,
                                    controller: gstController,
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
String? selectedValue;