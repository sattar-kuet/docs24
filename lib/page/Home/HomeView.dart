import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:docs24/page/Home/Model/emailLog.dart';
import 'package:docs24/page/Home/Provider/homeProvider.dart';
import 'package:docs24/page/SendMail/sendMailView.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'components/MenuDrawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>.value(
      value: HomeProvider()..getEmailLog(),
      child: Consumer<HomeProvider>(
        builder: (context, stateAction, __) {
          List<EmailLogModel> emailLogs = stateAction.emailLog;

          return LoadingOverlay(
            isLoading: stateAction.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Email Log"),
                centerTitle: true,
              ),
              drawer: const MenuDrawer(),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SendMailView(),
                    ),
                  );
                },
                child: const Icon(Icons.send),
              ),
              body: SafeArea(
                child: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: ListView.builder(
                    itemCount: emailLogs.length,
                    itemBuilder: (context, index) {
                      EmailLogModel emailLog = emailLogs[index];

                      return Card(
                        child: ListTile(
                          title: Text('Subject: ${emailLog.subject}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Sent at: ${emailLog.time}'),
                              Text('Sent to: ${emailLog.receiverEmail}')
                            ],
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
