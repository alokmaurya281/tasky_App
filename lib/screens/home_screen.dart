// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tasky_app/apis/authentication.dart';
import 'package:tasky_app/apis/projects_services.dart';
import 'package:tasky_app/models/checkpoints.dart';
import 'package:tasky_app/models/project_model.dart';
import 'package:tasky_app/models/task_model.dart';
import 'package:tasky_app/screens/project_information.dart';
import 'package:tasky_app/screens/tasks_information_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            scrollDirection: Axis.vertical,
            primary: true,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              const SizedBox(
                height: 20,
              ),
              _appBar(),
              const SizedBox(
                height: 16,
              ),
              _taskProgressViewCard(context),
              _inProgressTasksItems(context),
              _taskGroupsCards(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding _taskGroupsCards(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Projects',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8,
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
                    List<Project> list =
                        data?.map((e) => Project.fromJson(e.data())).toList() ??
                            [];
                    return SizedBox(
                      width: double.infinity,
                      height: (90.0 * list.length),
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: list.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: StreamBuilder(
                                stream: ProjectServices.getAllMyTaskByProject(
                                  list[index].id,
                                ),
                                builder: (context, snapshot) {
                                  final data = snapshot.data?.docs;
                                  List<TaskModel> listTasks = data
                                          ?.map((e) =>
                                              TaskModel.fromJson(e.data()))
                                          .toList() ??
                                      [];

                                  return StreamBuilder(
                                      stream: ProjectServices
                                          .filterTaskByandProjectByStatus(
                                              list[index].id, 'Completed'),
                                      builder: (context, snapshot) {
                                        final data = snapshot.data?.docs;
                                        List<TaskModel> completedTask = data
                                                ?.map((e) => TaskModel.fromJson(
                                                    e.data()))
                                                .toList() ??
                                            [];
                                        final double progress = ProjectServices
                                            .countProjectProgress(
                                                listTasks.length.toDouble(),
                                                completedTask.length
                                                    .toDouble());
                                        // final double progress = 100.0;
                                        return ListTile(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return ProjectInformationScreen(
                                                project: list[index],
                                              );
                                            }));
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          tileColor: const Color.fromARGB(
                                              118, 219, 215, 255),
                                          title: Text(
                                            list[index].projectName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${listTasks.length} Tasks',
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          leading: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    list[index].projectIcon,
                                              ),
                                            ),
                                          ),
                                          trailing: CircularPercentIndicator(
                                            lineWidth: 6,
                                            percent: (progress / 100),
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    56, 250, 173, 250),
                                            progressColor: const Color.fromARGB(
                                                255, 250, 173, 250),
                                            radius: 25,
                                            center: Text(
                                              '${progress.toStringAsFixed(2)}%',
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Projects',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }
              }
            },
          ),
        ],
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
              'In Progress',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
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
                                                ?.map((e) =>
                                                    CheckPoints.fromJson(
                                                        e.data()))
                                                .toList() ??
                                            [];
                                    // print(checkPointsAll?.length);
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
                                          child: Card(
                                            margin: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            color: const Color.fromARGB(
                                                255, 239, 225, 255),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 16),
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

  Padding _taskProgressViewCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: StreamBuilder(
        stream: ProjectServices.filterTaskByDate(),
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
              final data = snapshot.data?.docs;
              List<TaskModel> list =
                  data?.map((e) => TaskModel.fromJson(e.data())).toList() ?? [];
              return StreamBuilder(
                stream: ProjectServices.filterTaskByDateAndStatus('Completed'),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  List<TaskModel> compltedTasks =
                      data?.map((e) => TaskModel.fromJson(e.data())).toList() ??
                          [];

                  final double progress = ProjectServices.countProjectProgress(
                      list.length.toDouble(), compltedTasks.length.toDouble());
                  return Card(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  progress <= 0.0
                                      ? 'Your today\'s task is Pending!.'
                                      : progress <= 50.0
                                          ? 'Your today\'s task half done!.'
                                          : progress <= 75.0
                                              ? 'Your today\'s task almost done!.'
                                              : progress < 100.0
                                                  ? 'Your today\'s task about to done!.'
                                                  : 'Your today\'s task is Completed!.',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                  child: Text(
                                    'View Task',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: CircularPercentIndicator(
                              lineWidth: 8,
                              percent: progress / 100,
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(.5),
                              progressColor: Colors.white,
                              radius: 35,
                              center: Text(
                                '${progress.toStringAsFixed(2)}%',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            height: 100,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: IconButton(
                                      style: IconButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(.5),
                                      ),
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.more_horiz,
                                        size: 24,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }

  Widget _appBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                SizedBox(
                  width: 50,
                  height: 50,
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      Authentication.user.photoURL ??
                          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      Authentication.user.displayName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
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
        ),
      ],
    );
  }
}
