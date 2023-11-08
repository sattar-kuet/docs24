import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:docs24/page/Contact/Model/contactModel.dart';
import 'package:docs24/page/Contact/Provider/contactListProvider.dart';

import 'package:docs24/page/Home/components/MenuDrawer.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContactListProvider>(
      create: (context) => ContactListProvider()..getContactList(),
      child: Consumer<ContactListProvider>(
        builder: (context, stateAction, __) {
          List<ContactModel> contacts = stateAction.contactList;

          return LoadingOverlay(
            isLoading: stateAction.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Contact List"),
                centerTitle: true,
              ),
              drawer: const MenuDrawer(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/contactManage',
                    arguments: ContactModel(),
                    (route) => false,
                  );
                },
                child: const Icon(Icons.add),
              ),
              body: SafeArea(
                child: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: ListView.builder(
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      ContactModel contact = contacts[index];

                      return Card(
                        child: ListTile(
                          title: Text('Name: ${contact.name}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email: ${contact.email}'),
                              Text(
                                  'Phone: ${contact.countryCode} ${contact.phone}'),
                              Text('Company: ${contact.companyName}'),
                            ],
                          ),
                          trailing: TextButton(
                            child: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/contactManage',
                                arguments: contact,
                                (route) => false,
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
