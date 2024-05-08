// import 'dart:io';
//
// import 'package:auto_size_text_field/auto_size_text_field.dart';
// import 'package:date_field/date_field.dart';
// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:mailbox/page/quote/screens/select_date/select_date.dart';
// import 'package:provider/provider.dart';
//
// import '../../../widgets/text_button.dart';
// import '../../SendMail/Provider/sendMailProvider.dart';
// class QuoteInput extends StatefulWidget {
//   const QuoteInput({super.key});
//
//   @override
//   State<QuoteInput> createState() => _QuoteInputState();
// }
//
// class _QuoteInputState extends State<QuoteInput> {
//   final compoanyNameController= TextEditingController();
//   final comopanyAddressController= TextEditingController();
//   final quoteNameController= TextEditingController();
//   final quoteAddressController= TextEditingController();
//   final expireDateController= TextEditingController();
//   final referenceController= TextEditingController();
//   final abnacnController= TextEditingController();
//   final descriptionController= TextEditingController();
//   final quantityController= TextEditingController();
//   final unitPriceController= TextEditingController();
//   final gstController= TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   int quantiry=0,price=0;
//   XFile? _image;
//   int _selectedValue = 1;
//   String selec_vlaue="ABN";
//   int amount_aud=0;
//   int sub_total=0;
//   double gst=0;
//   double total_gst=0;
//   Future<void> getImage() async {
//     final XFile? image =
//     await _picker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       _image = image;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//           setState(() {
//             amount_aud=quantiry*price;
//             sub_total=sub_total+amount_aud;
//             if(gst>0){
//               total_gst=(total_gst+(gst*sub_total)/100);
//             }
//           });
//         },
//         child: const Text('Submit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
//         shape: const CircleBorder(),
//         backgroundColor: Colors.blue.shade300,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Gap(10),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.grey.shade200,
//                 child: const Padding(
//                   padding: EdgeInsets.only(left: 17.0, top: 3, bottom: 3),
//                   child: Text('Company Info', style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600
//                   ),),
//                 ),
//               ),
//               Padding(
//                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 17),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: [
//                    Column(
//                      children: [
//                        SizedBox(
//                          width: MediaQuery.of(context).size.width/2,
//                          child: TextField(
//                            cursorColor: Colors.blue,
//                            controller: compoanyNameController,
//                            decoration: const InputDecoration(
//                              hintText: "Write Company Name",
//                              enabledBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(color: Colors.blue),
//                              ),
//                              focusedBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(color: Colors.blue),
//                              ),
//                            ),
//                          ),
//                        ),
//                        SizedBox(
//                          width: MediaQuery.of(context).size.width/2,
//                          child: TextField(
//                            cursorColor: Colors.blue,
//                            controller: comopanyAddressController,
//                            decoration: const InputDecoration(
//                              hintText: "Write Company Address",
//                              enabledBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(color: Colors.blue),
//                              ),
//                              focusedBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(color: Colors.blue),
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//
//                    SizedBox(
//                      child: GestureDetector(
//                        onTap: getImage,
//                        child: Container(
//                          width: 60,
//                          height: 60,
//                          decoration: BoxDecoration(
//                            border: Border.all(color: Colors.transparent),
//                            borderRadius: BorderRadius.circular(30),
//                          ),
//                          child: _image == null
//                              ? ClipRRect(
//                            borderRadius: BorderRadius.circular(100),
//                              child: const Image(image: AssetImage("assets/logo.jpeg"),fit: BoxFit.fill,))
//                              : ClipRRect(
//                              borderRadius: BorderRadius.circular(100),
//                              child: Image.file(File(_image!.path), fit: BoxFit.fitWidth,))
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//               const Gap(20),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.grey.shade200,
//                 child: const Padding(
//                   padding: EdgeInsets.only(left: 17.0, top: 3, bottom: 3),
//                   child: Text('Quote To', style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600
//                   ),),
//                 ),
//               ),
//               const Gap(10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical:5, horizontal: 17),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Name', style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),),
//                     TextField(
//                       cursorColor: Colors.blue,
//                       controller: quoteNameController,
//                       decoration: InputDecoration(
//                         hintText: "Client Name",
//                         contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0), // Adjust the values as needed
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                       ),
//                     ),
//                     const Gap(10),
//                     const Text('Address', style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),),
//                     TextField(
//                       cursorColor: Colors.blue,
//                       maxLines: 3,
//                       controller: quoteAddressController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                       ),
//                     )
//
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Date', style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),),
//                     DateTimeFormField(
//                       decoration: const InputDecoration(
//                         fillColor: Color.fromARGB(255, 224, 241, 255),
//                         filled: true,
//                         hintStyle: TextStyle(color: Colors.black45),
//                         errorStyle: TextStyle(color: Colors.redAccent),
//                         border: OutlineInputBorder(
//                             borderSide: BorderSide.none),
//                         suffixIcon: Icon(Icons.event_note),
//                         hintText: 'Select Date',
//                       ),
//                       mode: DateTimeFieldPickerMode.date,
//                       autovalidateMode: AutovalidateMode.always,
//                       onDateSelected: (DateTime value) {
//                         final formattedDate =
//                         DateFormat('d MMMM, y').format(value);
//                         Provider.of<SendMailProvider>(context,
//                             listen: false)
//                             .setSelectedDate(formattedDate.toString());
//                       },
//                     ),
//                     const Gap(10),
//                     const Text('Expired date', style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),),
//                     TextField(
//                       cursorColor: Colors.blue,
//                       controller: expireDateController,
//                       decoration: InputDecoration(
//                         hintText: "Write expire date in days ",
//                         contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0), // Adjust the values as needed
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                       ),
//                     ),
//                     const Gap(10),
//                     const Text('Reference: ', style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),),
//                     TextField(
//                       cursorColor: Colors.blue,
//                       maxLines: 3,
//                       controller: referenceController,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Radio<int>(
//                       fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
//                       value: 1,
//                       groupValue: _selectedValue,
//                       onChanged: (int? value) {
//                         setState(() {
//                           _selectedValue = value!;
//                           selec_vlaue="ABN";
//                         });
//                       },
//                     ),
//                     const Text('ABN'),
//                     Radio<int>(
//                       fillColor: MaterialStateColor.resolveWith((states) => Colors.blue),
//                       value: 2,
//                       groupValue: _selectedValue,
//                       onChanged: (int? value) {
//                         setState(() {
//                           _selectedValue = value!;
//                           selec_vlaue="ACN";
//                         });
//                       },
//                     ),
//                     const Text('ACN'),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 17),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('${selec_vlaue} Number', style: const TextStyle(
//                       fontWeight: FontWeight.w500,
//                       fontSize: 14,
//                     ),),
//                     TextField(
//                       cursorColor: Colors.blue,
//                       controller: quoteNameController,
//                       decoration: InputDecoration(
//                         hintText: "${selec_vlaue} Number",
//                         contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0), // Adjust the values as needed
//                         border: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(color: Colors.blue),
//                           borderRadius: BorderRadius.circular(5.0), // Adjust the value as needed
//                         ),
//                       ),
//                     ),
//                     const Gap(30),
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.grey.shade600,
//                           width: 1
//                         ),
//                         borderRadius: BorderRadius.circular(5)
//                       ),
//                       child: Stack(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Text("Select Item",style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.w500
//                                     ),),
//                                     const Gap(10),
//                                     Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             border: Border.all(
//                                                 color: Colors.grey.shade600,
//                                                 width: 1
//                                             )
//                                         ),
//                                         child: DropdownButtonHideUnderline(
//                                           child: DropdownButton2<String>(
//                                             isExpanded: true,
//                                             hint: Text(
//                                               'Select Item',
//                                               style: TextStyle(
//                                                 fontSize: 14,
//                                                 color: Theme.of(context).hintColor,
//                                               ),
//                                             ),
//                                             items: items
//                                                 .map((String item) => DropdownMenuItem<String>(
//                                               value: item,
//                                               child: Text(
//                                                 item,
//                                                 style: const TextStyle(
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                             ))
//                                                 .toList(),
//                                             value: selectedValue,
//                                             onChanged: (String? value) {
//                                               setState(() {
//                                                 selectedValue = value;
//                                               });
//                                             },
//                                             buttonStyleData: const ButtonStyleData(
//                                               padding: EdgeInsets.symmetric(horizontal: 16),
//                                               height: 40,
//                                               width: 140,
//                                             ),
//                                             menuItemStyleData: const MenuItemStyleData(
//                                               height: 40,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/3.5,
//                                       child: const Text("Description: ",style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w500
//                                       ),),
//                                     ),
//                                     const Gap(10),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/2.5,
//                                       child: TextField(
//                                         cursorColor: Colors.blue,
//                                         controller: descriptionController,
//                                         decoration: const InputDecoration(
//                                           enabledBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.blue),
//                                           ),
//                                           focusedBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.blue),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/3.5,
//                                       child: const Text("Quantity: ",style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w500
//                                       ),),
//                                     ),
//                                     const Gap(10),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/2.5,
//                                       child: TextField(
//                                         cursorColor: Colors.blue,
//                                         controller: quantityController,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             value==""? quantiry =int.parse("0"):quantiry =int.parse(value);
//                                           });
//                                         },
//
//                                         decoration: const InputDecoration(
//                                           enabledBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.blue),
//                                           ),
//                                           focusedBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.blue),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/3.5,
//                                       child: const Text("Unit Price: ",style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w500
//                                       ),),
//                                     ),
//                                     const Gap(10),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/2.5,
//                                       child: TextField(
//                                         cursorColor: Colors.blue,
//                                         controller: unitPriceController,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             if(value==""){
//                                               price =int.parse("0");
//                                             }else{
//                                               price =int.parse(value);
//                                             }
//                                           });
//                                         },
//                                         decoration: const InputDecoration(
//                                           enabledBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.blue),
//                                           ),
//                                           focusedBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.blue),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/3.5,
//                                       child: const Text("GST: ",style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w500
//                                       ),),
//                                     ),
//                                     const Gap(10),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/2.5,
//                                       child: TextField(
//                                         cursorColor: Colors.blue,
//                                         controller: gstController,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             value==""?gst =double.parse("0"):gst =double.parse(value) ;
//                                           });
//                                         },
//                                         decoration: const InputDecoration(
//                                           hintText: "%",
//                                           enabledBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.blue),
//                                           ),
//                                           focusedBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(color: Colors.blue),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                                 const Gap(10),
//                                 Row(
//                                   children: [
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/3.5,
//                                       child: const Text("Amount AUD: ",style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w500
//                                       ),),
//                                     ),
//                                     const Gap(10),
//                                     SizedBox(
//                                       width: MediaQuery.of(context).size.width/2.5,
//                                       child:  Text( "${quantiry*price}",style: const TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w500
//                                       ),),
//                                     ),
//
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             right: 10,
//                             bottom: 10,
//                             child: GestureDetector(
//                               onTap: (){
//
//                               },
//                               child: Container(
//                                 height: 40,
//                                 width: 40,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(100),
//                                     color: Colors.red
//                                 ),
//                                 child: const Center(
//                                   child: Text('Add', style: TextStyle(
//                                     fontSize: 16, fontWeight: FontWeight.bold,
//                                     color: Colors.white
//                                   ),),
//                                 ),
//                               ),
//                             ),
//                           )
//
//                         ],
//                       ),
//                     ),
//                     const Gap(20),
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                               color: Colors.grey.shade600,
//                               width: 1
//                           ),
//                           borderRadius: BorderRadius.circular(5)
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width/3.5,
//                                   child: const Text("Subtotal: ",style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500
//                                   ),),
//                                 ),
//                                 const Gap(10),
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width/2.5,
//                                   child:  Text( "${sub_total}",style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500
//                                   ),),
//                                 ),
//
//                               ],
//                             ),
//                             const Gap(10),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width/3.5,
//                                   child: const Text("Total GST: ",style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500
//                                   ),),
//                                 ),
//                                 const Gap(10),
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width/2.5,
//                                   child:  Text( "${total_gst}",style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500
//                                   ),),
//                                 ),
//
//                               ],
//                             ),
//                             const Gap(10),
//                             Row(
//                               children: [
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width/3.5,
//                                   child: const Text("Total AUD: ",style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500
//                                   ),),
//                                 ),
//                                 const Gap(10),
//                                 SizedBox(
//                                   width: MediaQuery.of(context).size.width/2.5,
//                                   child:  Text( "${total_gst+sub_total}",style: const TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500
//                                   ),),
//                                 ),
//
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// final List<String> items = [
//   'Item1',
//   'Item2',
//   'Item3',
//   'Item4',
// ];
// String? selectedValue;


import 'dart:io';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mailbox/page/quote/screens/itemsInfo.dart';
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
  List<ItemsInfo> contacts = List.empty(growable: true);

  int selectedIndex = -1;
  int quantiry=0,price=0;
  XFile? _image;
  int _selectedValue = 1;
  String selec_vlaue="ABN";
  int amount_aud=0;
  int sub_total=0;
  double gst=0;
  double total_gst=0;
  Future<void> getImage() async {
    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
  List<Widget> containers = [];

  void _addContainer() {
    containers.add(
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Your existing UI code for the form fields...
          SizedBox(
            height: 300, // Example height
            width: double.infinity, // Take full width
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                // child: Padding(
                //   padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0),
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Row(
                //         children: [
                //           const Text("Select Item",style: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.w500
                //           ),),
                //           const Gap(10),
                //           Align(
                //             alignment: Alignment.topLeft,
                //             child: Container(
                //               decoration: BoxDecoration(
                //                   border: Border.all(
                //                       color: Colors.grey.shade600,
                //                       width: 1
                //                   )
                //               ),
                //               child: DropdownButtonHideUnderline(
                //                 child: DropdownButton2<String>(
                //                   isExpanded: true,
                //                   hint: Text(
                //                     'Select Item',
                //                     style: TextStyle(
                //                       fontSize: 14,
                //                       color: Theme.of(context).hintColor,
                //                     ),
                //                   ),
                //                   items: items
                //                       .map((String item) => DropdownMenuItem<String>(
                //                     value: item,
                //                     child: Text(
                //                       item,
                //                       style: const TextStyle(
                //                         fontSize: 14,
                //                       ),
                //                     ),
                //                   ))
                //                       .toList(),
                //                   value: selectedValue,
                //                   onChanged: (String? value) {
                //                     setState(() {
                //                       selectedValue = value;
                //                     });
                //                   },
                //                   buttonStyleData: const ButtonStyleData(
                //                     padding: EdgeInsets.symmetric(horizontal: 16),
                //                     height: 40,
                //                     width: 140,
                //                   ),
                //                   menuItemStyleData: const MenuItemStyleData(
                //                     height: 40,
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/3.5,
                //             child: const Text("Description: ",style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w500
                //             ),),
                //           ),
                //           const Gap(10),
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/2.5,
                //             child: TextField(
                //               cursorColor: Colors.blue,
                //               controller: descriptionController,
                //               decoration: const InputDecoration(
                //                 enabledBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.blue),
                //                 ),
                //                 focusedBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.blue),
                //                 ),
                //               ),
                //             ),
                //           ),
                //
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/3.5,
                //             child: const Text("Quantity: ",style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w500
                //             ),),
                //           ),
                //           const Gap(10),
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/2.5,
                //             child: TextField(
                //               cursorColor: Colors.blue,
                //               controller: quantityController,
                //               onChanged: (value) {
                //                 setState(() {
                //                   value==""? quantiry =int.parse("0"):quantiry =int.parse(value);
                //                 });
                //               },
                //
                //               decoration: const InputDecoration(
                //                 enabledBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.blue),
                //                 ),
                //                 focusedBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.blue),
                //                 ),
                //               ),
                //             ),
                //           ),
                //
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/3.5,
                //             child: const Text("Unit Price: ",style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w500
                //             ),),
                //           ),
                //           const Gap(10),
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/2.5,
                //             child: TextField(
                //               cursorColor: Colors.blue,
                //               controller: unitPriceController,
                //               onChanged: (value) {
                //                 setState(() {
                //                   if(value==""){
                //                     price =int.parse("0");
                //                   }else{
                //                     price =int.parse(value);
                //                   }
                //                 });
                //               },
                //               decoration: const InputDecoration(
                //                 enabledBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.blue),
                //                 ),
                //                 focusedBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.blue),
                //                 ),
                //               ),
                //             ),
                //           ),
                //
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/3.5,
                //             child: const Text("GST: ",style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w500
                //             ),),
                //           ),
                //           const Gap(10),
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/2.5,
                //             child: TextField(
                //               cursorColor: Colors.blue,
                //               controller: gstController,
                //               onChanged: (value) {
                //                 setState(() {
                //                   value==""?gst =double.parse("0"):gst =double.parse(value) ;
                //                 });
                //               },
                //               decoration: const InputDecoration(
                //                 hintText: "%",
                //                 enabledBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.blue),
                //                 ),
                //                 focusedBorder: UnderlineInputBorder(
                //                   borderSide: BorderSide(color: Colors.blue),
                //                 ),
                //               ),
                //             ),
                //           ),
                //
                //         ],
                //       ),
                //       const Gap(10),
                //       Row(
                //         children: [
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/3.5,
                //             child: const Text("Amount AUD: ",style: TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w500
                //             ),),
                //           ),
                //           const Gap(10),
                //           SizedBox(
                //             width: MediaQuery.of(context).size.width/2.5,
                //             child:  Text( "${quantiry*price}",style: const TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.w500
                //             ),),
                //           ),
                //
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onAddButtonPressed() {
    // Add container on button press
    _addContainer();
    // Update the state to reflect the changes
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     setState(() {
      //       amount_aud=quantiry*price;
      //       sub_total=sub_total+amount_aud;
      //       if(gst>0){
      //         total_gst=(total_gst+(gst*sub_total)/100);
      //       }
      //     });
      //   },
      //   child: const Text('Submit', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
      //   shape: const CircleBorder(),
      //   backgroundColor: Colors.blue.shade300,
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0),
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
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          content: SingleChildScrollView(
                            child: SizedBox(
                              height: 370,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text("Select Item:",style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500
                                            ),),
                                            const Gap(25),
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

                                                        selectedValue = value;
                                                        FocusScope.of(context).unfocus();

                                                    },
                                                    buttonStyleData: const ButtonStyleData(
                                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                                      height: 30,
                                                      width: 120,
                                                    ),
                                                    menuItemStyleData: const MenuItemStyleData(
                                                      height: 20,
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
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ),
                                            const Gap(10),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width/3.5,
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
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ),
                                            const Gap(10),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width/3.5,
                                              child: TextField(
                                                cursorColor: Colors.blue,
                                                controller: quantityController,
                                                onChanged: (value) {
                                                  setState(() {
                                                    value==""? quantiry =int.parse("0"):quantiry =int.parse(value);
                                                  });
                                                },

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
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width/4,
                                              child: const Text("Unit Price: ",style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ),
                                            const Gap(10),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width/3.5,
                                              child: TextField(
                                                cursorColor: Colors.blue,
                                                controller: unitPriceController,
                                                onChanged: (value) {
                                                  setState(() {
                                                    if(value==""){
                                                      price =int.parse("0");
                                                    }else{
                                                      price =int.parse(value);
                                                    }
                                                  });
                                                },
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
                                        const Gap(20),
                                        Row(
                                          children: [
                                            const Text("Select GST:",style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500
                                            ),),
                                            const Gap(30),
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
                                                      'gst',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Theme.of(context).hintColor,
                                                      ),
                                                    ),
                                                    items: gstItem
                                                        .map((String item) => DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ))
                                                        .toList(),
                                                    value: selectedGst,
                                                    onChanged: (String? value) {

                                                        selectedGst = value;
                                                        FocusScope.of(context).unfocus();

                                                    },
                                                    buttonStyleData: const ButtonStyleData(
                                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                                      height: 30,
                                                      width: 120,
                                                    ),
                                                    menuItemStyleData: const MenuItemStyleData(
                                                      height: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width/4,
                                              child: const Text("Amount AUD: ",style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ),
                                            const Gap(10),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width/3.5,
                                              child:  Text( "${quantiry*price}",style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            //
                                            String description = descriptionController.text.trim();
                                            String quantity = quantityController.text.trim();
                                            String unitPrice=unitPriceController.text.trim();
                                            String selectedItem=selectedValue!;
                                            String selectedGstItem=selectedGst!;
                                            int totalAud=int.parse(quantity)*int.parse(unitPrice);
                                            if (description.isNotEmpty && quantity.isNotEmpty && selectedItem.isNotEmpty && unitPrice.isNotEmpty && selectedGst!.isNotEmpty && selectedItem!.isNotEmpty) {
                                              setState(() {
                                                descriptionController.text = '';
                                                quantityController.text = '';
                                                unitPriceController.text='';
                                                contacts.add(ItemsInfo(item: selectedItem,description: description, quantity: quantity, unitPrice: unitPrice, gst: selectedGstItem, TAUD: totalAud));

                                              });
                                            }
                                            Navigator.of(context).pop();
                                            //
                                          },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600), // Set the button's background color
                                        ),
                                        child: const Text('Save', style: TextStyle(color: Colors.white)),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            //
                                            String item=selectedValue!.trim();
                                            String description = descriptionController.text.trim();
                                            String quantity = quantityController.text.trim();
                                            String unitPrice=unitPriceController.text.trim();
                                            String gst=selectedGst!.trim();
                                            if (description.isNotEmpty && quantity.isNotEmpty && unitPrice.isNotEmpty) {
                                              setState(() {

                                                descriptionController.text = '';
                                                quantityController.text = '';
                                                unitPriceController.text='';

                                                contacts[selectedIndex].item=item;
                                                contacts[selectedIndex].description = description;
                                                contacts[selectedIndex].quantity = quantity;
                                                contacts[selectedIndex].unitPrice=unitPrice;
                                                contacts[selectedIndex].gst=gst;
                                                selectedIndex = -1;

                                              });
                                            }
                                            Navigator.of(context).pop();
                                            //
                                          },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600), // Set the button's background color
                                        ),
                                        child: const Text('Update', style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Text('Add Item'),
                ),

                    const SizedBox(height: 10),
                    contacts.isEmpty
                        ? const Text(
                      'No Contact yet..',
                      style: TextStyle(fontSize: 22),
                    )
                        :  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                          child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: contacts.length,
                          itemBuilder: (context, index) => getRow(index),
                                                ),
                        ),

                     Gap(20),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   decoration: BoxDecoration(
                    //       border: Border.all(
                    //           color: Colors.grey.shade600,
                    //           width: 1
                    //       ),
                    //       borderRadius: BorderRadius.circular(5)
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 12.0, top: 10.0, bottom: 10.0),
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             SizedBox(
                    //               width: MediaQuery.of(context).size.width/3.5,
                    //               child: const Text("Subtotal: ",style: TextStyle(
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w500
                    //               ),),
                    //             ),
                    //             const Gap(10),
                    //             SizedBox(
                    //               width: MediaQuery.of(context).size.width/2.5,
                    //               child:  Text( "${sub_total}",style: const TextStyle(
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w500
                    //               ),),
                    //             ),
                    //
                    //           ],
                    //         ),
                    //         const Gap(10),
                    //         Row(
                    //           children: [
                    //             SizedBox(
                    //               width: MediaQuery.of(context).size.width/3.5,
                    //               child: const Text("Total GST: ",style: TextStyle(
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w500
                    //               ),),
                    //             ),
                    //             const Gap(10),
                    //             SizedBox(
                    //               width: MediaQuery.of(context).size.width/2.5,
                    //               child:  Text( "${total_gst}",style: const TextStyle(
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w500
                    //               ),),
                    //             ),
                    //
                    //           ],
                    //         ),
                    //         const Gap(10),
                    //         Row(
                    //           children: [
                    //             SizedBox(
                    //               width: MediaQuery.of(context).size.width/3.5,
                    //               child: const Text("Total AUD: ",style: TextStyle(
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w500
                    //               ),),
                    //             ),
                    //             const Gap(10),
                    //             SizedBox(
                    //               width: MediaQuery.of(context).size.width/2.5,
                    //               child:  Text( "${total_gst+sub_total}",style: const TextStyle(
                    //                   fontSize: 18,
                    //                   fontWeight: FontWeight.w500
                    //               ),),
                    //             ),
                    //
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: containers.length,
                    //     itemBuilder: (contex, index) {
                    //       return containers[index];
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget getRow(int index) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width, // Set a fixed width for each card
      child: Card(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   contacts[index].description,
              //   style: const TextStyle(fontWeight: FontWeight.bold),
              // ),
              // Text(contacts[index].quantity),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Select Item: ",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                  //const Gap(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2.5,
                    child:  Text( contacts[index].item,style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),

                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Description: ",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                  //const Gap(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2.5,
                    child:  Text( contacts[index].description,style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),

                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Quantity: ",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                  //const Gap(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child:  Text( contacts[index].quantity,style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),

                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Unit Price: ",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                  //const Gap(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child:  Text( contacts[index].unitPrice,style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),

                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("GST ",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                  //const Gap(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child:  Text( contacts[index].gst,style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),

                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3.5,
                    child: const Text("Amount AUD: ",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                  //const Gap(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child:  Text( '${contacts[index].TAUD}',style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                    ),),
                  ),

                ],
              ),


          SizedBox(
            width: 50,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      //
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            content: SingleChildScrollView(
                              child: SizedBox(
                                height: 370,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Text("Select Item:",style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                              const Gap(25),
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

                                                          selectedValue = value;
                                                          FocusScope.of(context).unfocus();

                                                      },
                                                      buttonStyleData: const ButtonStyleData(
                                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                                        height: 30,
                                                        width: 120,
                                                      ),
                                                      menuItemStyleData: const MenuItemStyleData(
                                                        height: 20,
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
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                              ),
                                              const Gap(10),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width/3.5,
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
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                              ),
                                              const Gap(10),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width/3.5,
                                                child: TextField(
                                                  cursorColor: Colors.blue,
                                                  controller: quantityController,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      value==""? quantiry =int.parse("0"):quantiry =int.parse(value);
                                                    });
                                                  },

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
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width/4,
                                                child: const Text("Unit Price: ",style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                              ),
                                              const Gap(10),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width/3.5,
                                                child: TextField(
                                                  cursorColor: Colors.blue,
                                                  controller: unitPriceController,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      if(value==""){
                                                        price =int.parse("0");
                                                      }else{
                                                        price =int.parse(value);
                                                      }
                                                    });
                                                  },
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
                                          const Gap(20),
                                          Row(
                                            children: [
                                              const Text("Select GST:",style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                              const Gap(30),
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
                                                        'gst',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Theme.of(context).hintColor,
                                                        ),
                                                      ),
                                                      items: gstItem
                                                          .map((String item) => DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ))
                                                          .toList(),
                                                      value: selectedGst,
                                                      onChanged: (String? value) {

                                                          selectedGst = value;
                                                          FocusScope.of(context).unfocus();

                                                      },
                                                      buttonStyleData: const ButtonStyleData(
                                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                                        height: 30,
                                                        width: 120,
                                                      ),
                                                      menuItemStyleData: const MenuItemStyleData(
                                                        height: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Gap(10),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width/4,
                                                child: const Text("Amount AUD: ",style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                              ),
                                              const Gap(10),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width/3.5,
                                                child:  Text( "${quantiry*price}",style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500
                                                ),),
                                              ),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            //
                                            String description = descriptionController.text.trim();
                                            String quantity = quantityController.text.trim();
                                            String unitPrice=unitPriceController.text.trim();
                                            String selectedItem=selectedValue!;
                                            String selectedGstItem=selectedGst!;
                                            int totalAud=int.parse(quantity)*int.parse(unitPrice);
                                            if (description.isNotEmpty && quantity.isNotEmpty && selectedItem.isNotEmpty && unitPrice.isNotEmpty && selectedGst!.isNotEmpty && selectedItem!.isNotEmpty) {
                                              setState(() {
                                                descriptionController.text = '';
                                                quantityController.text = '';
                                                unitPriceController.text='';
                                                contacts.add(ItemsInfo(item: selectedItem,description: description, quantity: quantity, unitPrice: unitPrice, gst: selectedGstItem, TAUD: totalAud));

                                              });
                                            }
                                            Navigator.of(context).pop();
                                            //
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600), // Set the button's background color
                                          ),
                                          child: const Text('Save', style: TextStyle(color: Colors.white)),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            //
                                            String item=selectedValue!.trim();
                                            String description = descriptionController.text.trim();
                                            String quantity = quantityController.text.trim();
                                            String unitPrice=unitPriceController.text.trim();
                                            int totalAud=int.parse(quantity)*int.parse(unitPrice);
                                            String gst=selectedGst!.trim();
                                            if (description.isNotEmpty && quantity.isNotEmpty && unitPrice.isNotEmpty) {
                                              setState(() {

                                                descriptionController.text = '';
                                                quantityController.text = '';
                                                unitPriceController.text='';

                                                contacts[selectedIndex].item=item;
                                                contacts[selectedIndex].description = description;
                                                contacts[selectedIndex].quantity = quantity;
                                                contacts[selectedIndex].unitPrice=unitPrice;
                                                contacts[selectedIndex].gst=gst;
                                                contacts[selectedIndex].TAUD=totalAud;
                                                selectedIndex = -1;

                                              });
                                            }
                                            Navigator.of(context).pop();
                                            //
                                          },
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue.shade600), // Set the button's background color
                                          ),
                                          child: const Text('Update', style: TextStyle(color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      selectedValue=contacts[index].item;
                      descriptionController.text = contacts[index].description;
                      quantityController.text = contacts[index].quantity;
                      unitPriceController.text=contacts[index].unitPrice;
                      selectedGst=contacts[index].gst;
                      setState(() {
                        selectedIndex = index;
                      });
                      //
                    },
                    child: const Icon(Icons.edit)),
                InkWell(
                    onTap: (() {
                      //
                      setState(() {
                        contacts.removeAt(index);
                      });
                      //
                    }),
                    child: const Icon(Icons.delete)),
              ],
            ),
          ),
    ]
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
final List<String> gstItem = [
  'GST',
  'Non GST'
];
String? selectedGst;