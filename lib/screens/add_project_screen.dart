// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tasky_app/apis/projects_services.dart';
import 'package:tasky_app/utils/dialogs.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController teamMembersController = TextEditingController();

  String? pickedImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
                height: 10,
              ),
              _appBar(),
              const SizedBox(
                height: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Project Name',
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
                      controller: projectNameController,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        border: InputBorder.none,
                        hintText: 'Enter Project Name',
                      ),
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Project Description ',
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
                        hintText: 'Enter Project Description ',
                      ),
                      cursorColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Team Members',
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
                      controller: teamMembersController,
                      // onTap: () {
                      //   showBottomModal(context, TextEditingController(),
                      //       'Select Team Members', () => {});
                      // },
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: const InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        border: InputBorder.none,
                        hintText:
                            'Enter Email address of Team members Seprated By comma ',
                        // suffixIcon: IconButton(
                        //   onPressed: () async {
                        //     showBottomModal(context, TextEditingController(),
                        //         'Select Team Members', () => {});
                        //   },
                        //   icon: Icon(
                        //     Icons.arrow_drop_down,
                        //     size: 24,
                        //     color: Theme.of(context).primaryColor,
                        //   ),
                        // ),
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
                      readOnly: true,
                      controller: startDateController,
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
                          hintText: 'Project Start Date ',
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
                      readOnly: true,
                      controller: endDateController,
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
                          hintText: 'Project End Date ',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Choose Project Icon',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        child: Stack(
                          children: [
                            pickedImage != null
                                ? Image.file(File(pickedImage.toString()))
                                : Image.asset('assets/icons/tasky_logo.png'),
                            Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: () {
                                  imageModalBottomSheet();
                                },
                                icon: Icon(
                                  Icons.camera_alt,
                                  size: 24,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (projectNameController.text.isNotEmpty ||
                            descriptionController.text.isNotEmpty ||
                            teamMembersController.text.isNotEmpty ||
                            startDateController.text.isNotEmpty ||
                            endDateController.text.isNotEmpty) {
                          Dialogs.showProgressIndicator(context);
                          final isDone = await ProjectServices.createproject(
                            projectNameController.text,
                            descriptionController.text,
                            File(
                              pickedImage.toString(),
                            ),
                            teamMembersController.text,
                            startDateController.text,
                            endDateController.text,
                          );
                          if (isDone) {
                            Navigator.pop(context);
                            Dialogs.showSnackBar(
                                context, 'Project Added Successfully', false);
                            Navigator.pop(context);
                          } else {
                            Navigator.pop(context);
                            Dialogs.showSnackBar(
                                context, 'Plaese Try Again !', true);
                          }
                        } else {
                          Dialogs.showSnackBar(
                              context, 'All Fields required !', true);
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
              )
            ],
          ),
        ),
      ),
    );
  }

  void showBottomModal(BuildContext context, TextEditingController controller,
      String modalName, onSave) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 810,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 30, bottom: 16),
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
                          'Create New Group',
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
                  SizedBox(
                    height: 680,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            tileColor: Colors.white,
                            title: const Text(
                              'Office Project',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color.fromARGB(255, 250, 218, 218),
                              ),
                              child: const Icon(
                                Icons.shopping_bag,
                                size: 24,
                                color: Color.fromARGB(255, 175, 119, 119),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
          "Add Project",
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

  void imageModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 180,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ListView(
                children: [
                  Text(
                    'Choose Image',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          fixedSize: const Size(80, 80),
                        ),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          // Pick an image.
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (image != null) {
                            setState(() {
                              pickedImage = image.path;
                            });
                            Dialogs.showProgressIndicator(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } else {
                            Dialogs.showSnackBar(
                                context, 'Please select image', true);
                          }
                        },
                        child: Image.asset(
                          'assets/icons/gallery.png',
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          fixedSize: const Size(80, 80),
                        ),
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          // Pick an image.
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.camera,
                          );
                          if (image != null) {
                            setState(() {
                              pickedImage = image.path;
                              Dialogs.showProgressIndicator(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            });
                          } else {
                            Dialogs.showSnackBar(
                                context, 'Please select image', true);
                          }
                        },
                        child: Image.asset(
                          'assets/icons/camera.png',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void getCameraPermissions() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Dialogs.showSnackBar(
          context, 'We Need permission to capture Image', true);
    }
  }

  void getGalleyPermission() async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      Dialogs.showSnackBar(context, 'We Need permission to get Images', true);
    }
  }

  void getmicrophonepermission() async {
    var status = await Permission.microphone.status;
    if (status.isDenied) {
      Dialogs.showSnackBar(context, 'We Need permission to record audio', true);
    }
  }
}
