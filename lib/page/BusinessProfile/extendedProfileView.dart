// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:mailbox/components/inputBox.dart';
import 'package:mailbox/page/BusinessProfile/Provider/businessProfileProvider.dart';
import 'package:mailbox/page/BusinessProfile/components/imagePicker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../utility/helper.dart';

class ExtendedProfileView extends StatelessWidget {
  const ExtendedProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BusinessProfileProvider()..initialization(),
      child: Consumer<BusinessProfileProvider>(
          builder: (context, stateAction, __) {
        return LoadingOverlay(
          isLoading: stateAction.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Extended Profile Setup",
              ),
              centerTitle: true,
            ),
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
                      TextButton(
                        onPressed: () => logOut(context),
                        child: Text(
                          "Want to logout? Click here",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 12.sp,
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
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
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
                            Provider.of<BusinessProfileProvider>(context,
                                listen: false)
                              ..profileImage(imageFile)
                              ..btnEnableaction();
                          }
                        },
                        child: Text(
                          "Upload Profile Picture",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      // ignore: unrelated_type_equality_checks

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
                              stateAction.countryUpdate(country);
                            },
                            onSubmitted: (country) {
                              stateAction.countryUpdate(country);
                              stateAction.stateListUpdate(country);
                              stateAction.stateUpdate('');
                              Provider.of<BusinessProfileProvider>(context,
                                      listen: false)
                                  .extendedBtnEnableaction();
                            }),
                      ),

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
                            Provider.of<BusinessProfileProvider>(context,
                                    listen: false)
                                .extendedBtnEnableaction();
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
                            Provider.of<BusinessProfileProvider>(context,
                                    listen: false)
                                .extendedBtnEnableaction(),
                      ),
                      SizedBox(
                        width: 70.w,
                        height: 10.w,
                        child: ElevatedButton(
                          onPressed: !stateAction.btnEnable
                              ? null
                              : () => Provider.of<BusinessProfileProvider>(
                                      context,
                                      listen: false)
                                  .personalProfileAction(context),
                          child: Text(
                            "Create Profile",
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
