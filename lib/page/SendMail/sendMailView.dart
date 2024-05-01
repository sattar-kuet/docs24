import 'dart:convert';
import 'dart:typed_data';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mailbox/components/inputBox.dart';
import 'package:mailbox/page/SendMail/Model/emailtamplateModel.dart';
import 'package:mailbox/page/SendMail/Provider/sendMailProvider.dart';
import 'package:mailbox/page/SendMail/Widgets/signaturePadWidget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../Contact/Model/contactModel.dart';
import '../Home/components/MenuDrawer.dart';
import 'Widgets/selectedContactWidget.dart';
import 'package:intl/intl.dart';

class SendMailView extends StatefulWidget {
  const SendMailView({super.key});

  @override
  State<SendMailView> createState() => _SendMailViewState();
}

class _SendMailViewState extends State<SendMailView> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SendMailProvider>(context, listen: false)
        ..initialization()
        ..signatureAction()
        ..tamplateListAction()
        ..contactListaction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SendMailProvider>(builder: (context, stateAction, __) {
      return Scaffold(
          drawer: const MenuDrawer(),
          extendBodyBehindAppBar: false,
          appBar: AppBar(
            title: const Text("Send Email"),
          ),
          body: LoadingOverlay(
            isLoading: stateAction.isLoading,
            child: SafeArea(
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSearchableDropDown(
                            items: stateAction.contactList,
                            label: 'Select Email Address',
                            multiSelectTag: 'Email',
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 224, 241, 255),
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            multiSelect: true,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Icon(Icons.search),
                            ),
                            dropDownMenuItems:
                                stateAction.contactList.map((item) {
                              return item.value;
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                Provider.of<SendMailProvider>(context,
                                        listen: false)
                                    .mailSelectListDetails(
                                        (json.decode(value) as List)
                                            .map((e) =>
                                                int.parse(e['id'].toString()))
                                            .toList());
                              } else {
                                Provider.of<SendMailProvider>(context,
                                        listen: false)
                                    .clearAction();
                              }
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/contactManage',
                                  arguments: ContactModel(),
                                  (route) => false);
                            },
                            child: Text(
                              "Want to create new contact? Click here",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 12.sp,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                          if (stateAction.selectedContactList.isNotEmpty) ...[
                            SizedBox(
                              height: 3.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 41.w,
                              child: ListView.builder(
                                itemCount:
                                    stateAction.selectedContactList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) =>
                                    SelectContactWidget(
                                  stateAction: stateAction,
                                  index: index,
                                ),
                              ),
                            )
                          ],
                          SizedBox(
                            height: 20.sp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 224, 241, 255),
                              borderRadius: BorderRadius.circular(8.sp),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10.sp),
                            child: DropdownButton<String>(
                              value: stateAction
                                      .selectedMailTemplateCode.isNotEmpty
                                  ? stateAction.selectedMailTemplateCode
                                  : null,
                              elevation: 16,
                              isExpanded: true,
                              hint: const Text("Select Email Tamplate"),
                              underline: const SizedBox(),
                              onChanged: (String? value) =>
                                  Provider.of<SendMailProvider>(context,
                                          listen: false)
                                      .onSelectEmailTamplate(value.toString()),
                              items: stateAction.tamplateList
                                  .map<DropdownMenuItem<String>>(
                                      (EmailTamplateModel value) {
                                return DropdownMenuItem<String>(
                                  value: value.codeName,
                                  child: Text(value.name.toString()),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          if (stateAction.selectedMailTemplateCode ==
                                  "safe_work_method_statement_email_template" ||
                              stateAction.selectedMailTemplateCode ==
                                  "tiling_and_associated_works") ...[
                            InputBox(
                              controller: stateAction.projectName,
                              helperText: '',
                              hintText: 'Project Name',
                              onChange: (String value) {},
                            ),
                            InputBox(
                              controller: stateAction.clientName,
                              helperText: '',
                              hintText: 'Client Name',
                              onChange: (String value) {},
                            ),
                          ],
                          if (stateAction.selectedMailTemplateCode ==
                              "safe_work_method_statement_email_template") ...[
                            InputBox(
                              controller: stateAction.projectAddress,
                              helperText: '',
                              hintText: 'Project Address',
                              onChange: (String value) {},
                            ),
                          ],
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
                          SizedBox(
                            height: 5.h,
                          ),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => const SignaturePad(),
                                    ),
                                  )
                                  .then((value) => setState(() {
                                        Provider.of<SendMailProvider>(
                                          context,
                                          listen: false,
                                        ).signatureAction();
                                      }));
                            },
                            child: const Text("Signature"),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          if (stateAction.signature != false) ...[
                            Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: MemoryImage(Uint8List.fromList(
                                      base64Decode(stateAction.signature))),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            width: 60.w,
                            height: 12.w,
                            child: ElevatedButton(
                              onPressed: stateAction.isbtnEnabl
                                  ? () => Provider.of<SendMailProvider>(context,
                                          listen: false)
                                      .sendMailAction(context)
                                  : null,
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                    if (stateAction.isbtnEnabl) {
                                      // Return the color when the button is disabled
                                      return Colors.blue.shade200; // Change this to your desired color
                                    }
                                    // Return the color when the button is enabled
                                    return Colors.white; // Change this to your desired color
                                  },
                                ),
                              ),
                              child: Text(
                                "Send Mail",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
