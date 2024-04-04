import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'Model/job.dart';
import 'Provider/jobProvider.dart';
import 'components/MenuDrawer.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class JobDetailView extends StatelessWidget {
  const JobDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    int jobID = 0;
    jobID = ModalRoute.of(context)?.settings.arguments as int;

    return ChangeNotifierProvider<JobProvider>.value(
      value: JobProvider()..getJobDetail(jobID),
      child: Consumer<JobProvider>(
        builder: (context, stateAction, __) {
          JobModel job = stateAction.job;

          return LoadingOverlay(
            isLoading: stateAction.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Job Detail"),
                centerTitle: true,
              ),
              drawer: const MenuDrawer(),
              body: SafeArea(
                minimum: const EdgeInsets.all(16.0), // Adjust the padding as needed
                child: ListView(
                  children: [
                    Text(
                      job.title ??
                          '', // Display the title, or an empty string if null
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons
                                  .event_seat, // Use an appropriate icon for vacancy
                              size: 16.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              '${job.vacancy ?? 0}',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons
                                  .location_on, // Use an appropriate icon for location
                              size: 16.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              job.location ?? '',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons
                                  .timer, // Use an appropriate icon for deadline
                              size: 16.0,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              job.deadline ?? '',
                              style: const TextStyle(fontSize: 16.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    HtmlWidget(job.detail ?? ''),
                  ],
                ),
              ),
              bottomNavigationBar: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/jobApply', arguments: jobID);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.blue, // Button background color
                    ),
                  ),
                  child: const Text(
                    'Apply to this job',
                    style: TextStyle(
                      color: Colors.white, // Text color
                    ),
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
