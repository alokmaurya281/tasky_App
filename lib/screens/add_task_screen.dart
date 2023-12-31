// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/apis/projects_services.dart';
import 'package:tasky_app/models/project_model.dart';
import 'package:tasky_app/screens/add_project_screen.dart';
import 'package:tasky_app/utils/dialogs.dart';

class AddTaskProjectScreen extends StatefulWidget {
  const AddTaskProjectScreen({super.key});

  @override
  State<AddTaskProjectScreen> createState() => _AddTaskProjectScreenState();
}

class _AddTaskProjectScreenState extends State<AddTaskProjectScreen> {
  Project? selectedProject;
  TextEditingController projectController = TextEditingController();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController checkpointsController = TextEditingController();

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
                  Text(
                    'Task Name',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(246, 143, 143, 143),
                      ),
                    ),
                    child: TextFormField(
                      controller: taskNameController,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        border: InputBorder.none,
                        hintText: 'Enter Task Name',
                      ),
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Project',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(246, 143, 143, 143),
                      ),
                    ),
                    child: TextFormField(
                      controller: projectController,
                      readOnly: true,
                      onTap: () {
                        showBottomModal(context, TextEditingController(),
                            'Select Project', () => {});
                      },
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        border: InputBorder.none,
                        hintText: 'Select Project',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            showBottomModal(context, TextEditingController(),
                                'Select Project', () => {});
                          },
                          icon: Icon(
                            Icons.arrow_drop_down,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Task Description ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(246, 143, 143, 143),
                      ),
                    ),
                    child: TextFormField(
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        border: InputBorder.none,
                        hintText: 'Enter Task Description ',
                      ),
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Task CheckPoints ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(246, 143, 143, 143),
                      ),
                    ),
                    child: TextFormField(
                      controller: checkpointsController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        border: InputBorder.none,
                        hintMaxLines: null,
                        helperText:
                            'Exapmle: Create NavBar, Create Footer etc.',
                        hintText:
                            'Enter Task CheckPoints Followed by commas. This will be checkpoints that will calculate your task progress. e.g. Your task is develop a homepage of a website so your checkpoints may be, 1.Create NavBar 2. Create Footer etc. ',
                      ),
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Start Date',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(246, 143, 143, 143),
                      ),
                    ),
                    child: TextFormField(
                      controller: startDateController,
                      readOnly: true,
                      onTap: () async {
                        final startDate = await showDatePicker(
                          initialDate: DateTime.now(),
                          context: context,
                          firstDate: DateTime(2023),
                          lastDate: DateTime(3000),
                        );
                        setState(() {
                          dynamic date =
                              '${startDate!.day.toString()}/${startDate.month.toString()}/${startDate.year.toString()}';
                          startDateController.text = date;
                        });
                      },
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          border: InputBorder.none,
                          hintText: 'Task Start Date ',
                          suffixIcon: IconButton(
                            onPressed: () async {
                              final startDate = await showDatePicker(
                                initialDate: DateTime.now(),
                                context: context,
                                firstDate: DateTime(2023),
                                lastDate: DateTime(3000),
                              );
                              setState(() {
                                dynamic date =
                                    '${startDate!.day.toString()}/${startDate.month.toString()}/${startDate.year.toString()}';
                                startDateController.text = date;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_month,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          )),
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'End Date',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color.fromARGB(246, 143, 143, 143),
                      ),
                    ),
                    child: TextFormField(
                      controller: endDateController,
                      readOnly: true,
                      onTap: () async {
                        final endDate = await showDatePicker(
                          initialDate: DateTime.now(),
                          context: context,
                          firstDate: DateTime(2023),
                          lastDate: DateTime(3000),
                        );
                        setState(() {
                          dynamic date =
                              '${endDate!.day.toString()}/${endDate.month.toString()}/${endDate.year.toString()}';
                          endDateController.text = date;
                        });
                      },
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          border: InputBorder.none,
                          hintText: 'Task End Date ',
                          suffixIcon: IconButton(
                            onPressed: () async {
                              final endDate = await showDatePicker(
                                initialDate: DateTime.now(),
                                context: context,
                                firstDate: DateTime(2023),
                                lastDate: DateTime(3000),
                              );
                              setState(() {
                                dynamic date =
                                    '${endDate!.day.toString()}/${endDate.month.toString()}/${endDate.year.toString()}';
                                endDateController.text = date;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.calendar_month,
                            size: 24,
                            color: Theme.of(context).primaryColor,
                          )),
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (taskNameController.text.isNotEmpty &&
                            descriptionController.text.isNotEmpty &&
                            projectController.text.isNotEmpty &&
                            endDateController.text.isNotEmpty &&
                            startDateController.text.isNotEmpty &&
                            checkpointsController.text.isNotEmpty) {
                          Dialogs.showProgressIndicator(context);
                          final isDone = await ProjectServices.createTask(
                              taskNameController.text,
                              selectedProject!,
                              descriptionController.text,
                              startDateController.text,
                              endDateController.text,
                              checkpointsController.text);
                          if (isDone) {
                            Dialogs.showSnackBar(
                                context, 'Task Added Successfully', false);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                          }
                        } else {
                          Dialogs.showSnackBar(
                              context, 'All Fields Required', true);
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
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
          "Add Task",
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
                                        setState(() {
                                          selectedProject = list[index];
                                          projectController.text =
                                              selectedProject!.projectName;
                                        });
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
}
