// ignore_for_file: use_build_context_synchronously

import 'package:document_viewer/document_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'Provider/join_apply_provider.dart';

const _message = "Please upload your cv first";

class JobApplyView extends StatelessWidget {
  const JobApplyView({super.key});

  @override
  Widget build(BuildContext context) {
    int jobID = ModalRoute.of(context)?.settings.arguments as int;
    return ChangeNotifierProvider(
      create: (context) => JobApplyProvider(),
      child: Consumer<JobApplyProvider>(builder: (context, stateAction, __) {
        return LoadingOverlay(
          isLoading: stateAction.isLoading,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                "Upload CV",
              ),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: stateAction.docFile.isNotEmpty
                    ? () {
                        stateAction.docFileUploadaction(
                          context: context,
                          docFile: stateAction.docFile,
                          jobId: jobID,
                        );
                      }
                    : () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'pdf', 'doc'],
                        );
                        if (result != null) {
                          stateAction.docFileSetAction(
                            result.files.first.path.toString(),
                          );
                        }
                      },
                child: Icon(stateAction.docFile.isEmpty
                    ? Icons.file_upload
                    : Icons.done)),
            body: SafeArea(
                child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: stateAction.docFile.isEmpty
                  ? Center(
                      child: Text(
                        _message,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : DocumentViewer(
                      filePath: stateAction.docFile,
                    ),
            )),
          ),
        );
      }),
    );
  }
}
