// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:typed_data';
import 'package:csc_picker/csc_picker.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:docs24/components/inputBox.dart';
import 'package:docs24/page/BusinessProfile/Provider/businessProfileEditProvider.dart';
import 'package:docs24/page/BusinessProfile/components/imagePicker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../Home/components/MenuDrawer.dart';

class BusinessProfileEdit extends StatelessWidget {
  const BusinessProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessProfileEditProvider()
        ..initialization()
        ..categoeryListAction(),
      child: Consumer<BusinessProfileEditProvider>(
          builder: (context, stateAction, __) {
        return LoadingOverlay(
          isLoading: stateAction.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Business Profile",
              ),
              centerTitle: true,
            ),
            drawer: const MenuDrawer(),
            body: SafeArea(
                child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 4.h,
                      ),
                      stateAction.image.isNotEmpty
                          ? CircleAvatar(
                              radius: 30.sp,
                              backgroundImage: MemoryImage(
                                Uint8List.fromList(
                                  base64Decode(stateAction.image),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: 30.sp,
                              child: Icon(
                                Icons.business,
                                size: 30.sp,
                                color: Colors.white,
                              ),
                            ),
                      TextButton(
                        onPressed: () async {
                          String? imageFile = await showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const ImagePickerComponent();
                            },
                          );
                          if (imageFile != null) {
                            Provider.of<BusinessProfileEditProvider>(context,
                                listen: false)
                              ..profileImage(imageFile)
                              ..btnEnableaction();
                          }
                        },
                        child: Text(
                          "Change Logo",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      InputBox(
                        controller: stateAction.name,
                        helperText: '',
                        hintText: 'Business Name',
                        isNumber: false,
                        type: TextInputType.text,
                        onChange: (String value) =>
                            Provider.of<BusinessProfileEditProvider>(context,
                                    listen: false)
                                .btnEnableaction(),
                      ),
                      InputBox(
                        controller: stateAction.website,
                        helperText: '',
                        hintText: 'Website URL',
                        isNumber: true,
                        type: TextInputType.text,
                        onChange: (String value) =>
                            Provider.of<BusinessProfileEditProvider>(context,
                                    listen: false)
                                .btnEnableaction(),
                      ),
                      InputBox(
                        controller: stateAction.abn,
                        helperText: '',
                        hintText: 'Business ABN',
                        type: TextInputType.phone,
                        onChange: (String value) =>
                            Provider.of<BusinessProfileEditProvider>(context,
                                    listen: false)
                                .btnEnableaction(),
                      ),
                      // ignore: unrelated_type_equality_checks
                      if (stateAction.countryName.isNotEmpty ||
                          stateAction.startTyping == true)
                        Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: EasyAutocomplete(
                              initialValue: stateAction.countryName,
                              decoration: const InputDecoration(
                                labelText: "Country",
                              ),
                              suggestions: stateAction.countryList,
                              onChanged: (country) {
                                stateAction.updateStartTyping(true);
                                stateAction.countryUpdate(country);
                              },
                              onSubmitted: (country) {
                                stateAction.countryUpdate(country);
                                stateAction.stateListUpdate(country);
                                stateAction.stateUpdate('');
                              }),
                        ),
                      if (stateAction.countryName.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: EasyAutocomplete(
                            initialValue: stateAction.stateName,
                            decoration: const InputDecoration(
                              labelText: "State OR City",
                            ),
                            suggestions: stateAction.stateList,
                            onChanged: (state) {
                              stateAction.stateUpdate(state);
                            },
                            onSubmitted: (state) {
                              stateAction.stateUpdate(state);
                            },
                          ),
                        ),
                      InputBox(
                        controller: stateAction.address,
                        helperText: '',
                        hintText: 'Detail Address',
                        isNumber: false,
                        type: TextInputType.streetAddress,
                        onChange: (String value) =>
                            Provider.of<BusinessProfileEditProvider>(context,
                                    listen: false)
                                .btnEnableaction(),
                      ),
                      MultiSelectDialogField(
                        title: const Text('Select Category'),
                        initialValue: stateAction.selectcateDataList,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 224, 241, 255),
                          borderRadius: BorderRadius.circular(15.sp),
                        ),
                        searchable: true,
                        items: stateAction.categoryList
                            .map(
                                (e) => MultiSelectItem(e.id, e.name.toString()))
                            .toList(),
                        listType: MultiSelectListType.CHIP,
                        onConfirm: (values) {
                          Provider.of<BusinessProfileEditProvider>(context,
                              listen: false)
                            ..categoryInitAction(values
                                .map((e) => int.parse(e.toString()))
                                .toList())
                            ..btnEnableaction();
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(
                        width: 70.w,
                        height: 10.w,
                        child: ElevatedButton(
                          onPressed: !stateAction.btnEnable
                              ? null
                              : () => Provider.of<BusinessProfileEditProvider>(
                                      context,
                                      listen: false)
                                  .businessProfileAction(context),
                          child: Text(
                            "Save",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14.sp,
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
            )),
          ),
        );
      }),
    );
  }
}
