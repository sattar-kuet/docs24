// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:typed_data';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:docs24/components/inputBox.dart';
import 'package:docs24/page/BusinessProfile/Provider/extendedProfileEditProvider.dart';
import 'package:docs24/page/BusinessProfile/components/imagePicker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../Home/components/MenuDrawer.dart';

class ExtendedProfileEdit extends StatelessWidget {
  const ExtendedProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExtendedProfileEditProvider()..initialization(),
      child: Consumer<ExtendedProfileEditProvider>(
          builder: (context, stateAction, __) {
        return LoadingOverlay(
          isLoading: stateAction.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Extended Profile",
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
                            Provider.of<ExtendedProfileEditProvider>(context,
                                listen: false)
                              ..profileImage(imageFile)
                              ..btnEnableaction();
                          }
                        },
                        child: Text(
                          "Change Profile Picture",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
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
                            Provider.of<ExtendedProfileEditProvider>(context,
                                    listen: false)
                                .btnEnableaction(),
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
                              : () => Provider.of<ExtendedProfileEditProvider>(
                                      context,
                                      listen: false)
                                  .personalProfileAction(context),
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
