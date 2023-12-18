// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tasky_app/apis/projects_services.dart';
import 'package:tasky_app/models/checkpoints.dart';
import 'package:tasky_app/models/task_model.dart';

class TasksInformationScreen extends StatefulWidget {
  final TaskModel taskModel;
  const TasksInformationScreen({
    super.key,
    required this.taskModel,
  });

  @override
  State<TasksInformationScreen> createState() => _TasksInformationScreenState();
}

class _TasksInformationScreenState extends State<TasksInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: ListView(
          scrollDirection: Axis.vertical,
          primary: true,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 10,
            ),
            _appBar(),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.taskModel.taskName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Project DeadLine =>',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            widget.taskModel.endDate,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Project Manager =>',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            'Alok maurya',
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.taskModel.description,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  _inProgressTasksItems(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding _inProgressTasksItems(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              'CheckPoints',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 110,
              child: StreamBuilder(
                stream: ProjectServices.getAllCheckPointsByTask(
                    widget.taskModel.id),
                builder: (context, snapshot) {
                  final checkpoints = snapshot.data?.docs;
                  List<CheckPoints> checkpointsList = checkpoints
                          ?.map(
                            (e) => CheckPoints.fromJson(e.data()),
                          )
                          .toList() ??
                      [];
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    case ConnectionState.active:
                    case ConnectionState.done:
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: checkpointsList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.only(right: 16),
                            color: const Color.fromARGB(255, 226, 250, 255),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
                              child: SizedBox(
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      checkpointsList[index].checkpoint,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Status :: ',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          checkpointsList[index].status,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 24,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        Text(
          "Task Information",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ),
      ],
    );
  }
}
