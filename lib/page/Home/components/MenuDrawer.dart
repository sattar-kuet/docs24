// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/logo.dart';
import '../../../utility/helper.dart';
import '../../../utility/systemInfo.dart';
import '../../../widgets/draweritem.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(66, 199, 198, 201),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Logo(),
                ),
              ],
            ),
          ),
          drawerItem(
            icon: Icons.home,
            text: 'Dashboard',
            onTap: () => {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false)
            },
          ),
          drawerItem(
            icon: Icons.verified_user,
            text: 'Profile',
            onTap: () => {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/profile', (route) => false)
            },
          ),
          if (SystemInfo.getIsBusinessProfile == false &&
              SystemInfo.getIsOwner == true)
            drawerItem(
              icon: Icons.list,
              text: 'Email Log',
              onTap: () => {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/emailLog', (route) => false)
              },
            ),
          drawerItem(
            icon: Icons.verified_user,
            text: 'Extended Profile',
            onTap: () => {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/extendedProfileEdit', (route) => false)
            },
          ),

          if (SystemInfo.getIsBusinessProfile == true &&
              SystemInfo.getIsOwner == true)
            drawerItem(
              icon: Icons.business,
              text: 'Business Profile',
              onTap: () => {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/businessProfileEdit', (route) => false)
              },
            ),
          drawerItem(
            icon: Icons.contact_mail,
            text: 'Contact List',
            onTap: () => {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/contactList', (route) => false)
            },
          ),
          if (SystemInfo.getIsBusinessProfile == true &&
              SystemInfo.getIsOwner == true)
            drawerItem(
              icon: Icons.list,
              text: 'Employee List',
              onTap: () => {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/employeeList', (route) => false)
              },
            ),
          drawerItem(
            icon: Icons.send,
            text: 'Send Email',
            onTap: () => {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/sendMail', (route) => false)
            },
          ),
          const Divider(),

          Expanded(
            child: Container(),
          ), // this to force the bottom items to the lowest point
          Column(
            children: <Widget>[
              ListTile(
                title: const Row(
                  children: <Widget>[
                    Icon(Icons.logout),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text('Logout'),
                    )
                  ],
                ),
                onTap: () => logOut(context),
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    const Icon(Icons.code),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('Developed By'),
                          const SizedBox(height: 10.0),
                          GestureDetector(
                            onTap: () {
                              String url = "https://itscholarbd.com";
                              launch(url);
                            },
                            child: Container(
                              height: 50,
                              width: 125,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/ourlogo.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                onTap: () => logOut(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
