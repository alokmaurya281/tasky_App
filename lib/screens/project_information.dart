// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tasky_app/apis/authentication.dart';
import 'package:tasky_app/apis/projects_services.dart';
import 'package:tasky_app/models/checkpoints.dart';
import 'package:tasky_app/models/project_model.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/models/user_model.dart';
import 'package:tasky_app/screens/add_project_screen.dart';
import 'package:tasky_app/screens/tasks_information_screen.dart';

class ProjectInformationScreen extends StatefulWidget {
  final Project project;
  const ProjectInformationScreen({
    super.key,
    required this.project,
  });

  @override
  State<ProjectInformationScreen> createState() =>
      _ProjectInformationScreenState();
}

class _ProjectInformationScreenState extends State<ProjectInformationScreen> {
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
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        imageUrl: widget.project.projectIcon,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    widget.project.projectName,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Project DeadLine =>',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            widget.project.endDate,
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          StreamBuilder(
                              stream: Authentication.getuserInfo(
                                  widget.project.projectManager),
                              builder: (context, snapshot) {
                                final data = snapshot.data?.data();
                                return Text(
                                  data!['name'],
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                );
                              }),
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
                    widget.project.description,
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
                  _teamMembers(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _teamMembers(BuildContext context) {
    List<String> teamMembers = widget.project.teamMembers.split(',');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team Members',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: (90.0 * 10),
          child: ListView.builder(
            itemCount: teamMembers.length,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: StreamBuilder(
                    stream: Authentication.getuserbyEmail(teamMembers[index]),
                    builder: (context, snapshot) {
                      final userInfo = snapshot.data?.docs;
                      List<UserModel> users = userInfo
                              ?.map(
                                (e) => UserModel.fromJson(e.data()),
                              )
                              .toList() ??
                          [];
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        tileColor: const Color.fromARGB(118, 219, 215, 255),
                        title: Text(
                          users[0].name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          users[0].email,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: users[0].image,
                            ),
                          ),
                        ),
                      );
                    }),
              );
            },
          ),
        ),
      ],
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
              'Tasks',
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
              height: 120,
              width: double.infinity,
              child: StreamBuilder(
                stream: ProjectServices.getAllMyTasks(),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  List<TaskModel> list =
                      data?.map((e) => TaskModel.fromJson(e.data())).toList() ??
                          [];
                  if (list.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder(
                          stream: ProjectServices.getprojectInfo(
                            list[index].projectId,
                          ),
                          builder: (context, snapshot) {
                            final projectInfo = snapshot.data?.data();
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
                                return StreamBuilder(
                                  stream:
                                      ProjectServices.getAllCheckPointsByTask(
                                          list[index].id),
                                  builder: (context, snapshot) {
                                    final checkPointsAll = snapshot.data?.docs;
                                    List<CheckPoints> checkpointsList =
                                        checkPointsAll
                                                ?.map(
                                                  (e) => CheckPoints.fromJson(
                                                      e.data()),
                                                )
                                                .toList() ??
                                            [];
                                    return StreamBuilder(
                                      stream: ProjectServices
                                          .getCheckPointsByStatus(
                                              list[index].id, 'Completed'),
                                      builder: (context, snapshot) {
                                        final data = snapshot.data?.docs;
                                        // print(data);
                                        List<CheckPoints> completedCheckPoints =
                                            data
                                                    ?.map((e) =>
                                                        CheckPoints.fromJson(
                                                            e.data()))
                                                    .toList() ??
                                                [];
                                        final double progress = ProjectServices
                                            .countProjectProgress(
                                          checkpointsList.length.toDouble(),
                                          completedCheckPoints.length
                                              .toDouble(),
                                        );
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return TasksInformationScreen(
                                                    taskModel: list[index],
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                          onLongPress: () {
                                            showBottomModal(
                                                context,
                                                TextEditingController(),
                                                'Select Team Memeber',
                                                () {});
                                          },
                                          child: Card(
                                            margin: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            color: const Color.fromARGB(
                                                255, 239, 225, 255),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 16,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 160,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          projectInfo?[
                                                              'project_name'],
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                        Text(
                                                          list[index].taskName,
                                                          style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onPrimary,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        LinearPercentIndicator(
                                                          backgroundColor:
                                                              Colors.white,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          barRadius:
                                                              const Radius
                                                                  .circular(15),
                                                          lineHeight: 8.0,
                                                          percent:
                                                              progress / 100,
                                                          progressColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: CachedNetworkImage(
                                                        fit: BoxFit.cover,
                                                        imageUrl: projectInfo?[
                                                            'project_icon'],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Task Found',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  void showBottomModal(BuildContext context, TextEditingController controller,
      String modalName, onSave) {
    showModalBottomSheet(
        showDragHandle: true,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 600,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        modalName,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const AddProjectScreen();
                          }));
                        },
                        child: Text(
                          'Add New Project',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  StreamBuilder(
                    stream: ProjectServices.getAllMyprojects(),
                    builder: (context, snapshot) {
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
                          if (snapshot.hasData) {
                            final data = snapshot.data?.docs;
                            List<Project> list = data
                                    ?.map((e) => Project.fromJson(e.data()))
                                    .toList() ??
                                [];

                            return Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        // setState(() {
                                        //   selectedProject = list[index];
                                        //   projectController.text =
                                        //       selectedProject!.projectName;
                                        // });
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      tileColor: Colors.white,
                                      title: Text(
                                        list[index].projectName,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      leading: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color.fromARGB(
                                              255, 250, 218, 218),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: list[index].projectIcon,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: Text(
                                'No Projects',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        });
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
          "Project Information",
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
