import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'Model/job.dart';
import 'Provider/jobProvider.dart';
import 'components/MenuDrawer.dart';

class JobView extends StatelessWidget {
  const JobView({super.key});

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<JobProvider>.value(
      value: JobProvider()..getJobList(),
      child: Consumer<JobProvider>(
        builder: (context, stateAction, __) {
          List<JobModel> jobs = stateAction.jobList;

          return LoadingOverlay(
            isLoading: stateAction.isLoading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Job Openings"),
                centerTitle: true,
              ),
              drawer: const MenuDrawer(),
              body: SafeArea(
                child: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: ListView.builder(
                    itemCount: jobs.length,
                    itemBuilder: (context, index) {
                      JobModel job = jobs[index];

                      return Card(
                        child: ListTile(
                          title: Text(job.title.toString()),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Deadline: ${job.deadline}'),
                              Text('Job Location: ${job.location}')
                            ],
                          ),
                          trailing: TextButton(
                            child: Text('View Details'),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed('/jobDetail', arguments: job.id);
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
