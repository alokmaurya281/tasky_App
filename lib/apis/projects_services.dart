// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tasky_app/apis/authentication.dart';
import 'package:tasky_app/models/checkpoints.dart';
import 'package:tasky_app/models/project_model.dart';
import 'package:tasky_app/models/task_model.dart';

class ProjectServices {
  static Future<bool> createproject(
      String projectName,
      String description,
      File projectIcon,
      String teamMembers,
      String startDate,
      String endDate) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final userData = Authentication.user;
    final Project projectData = Project(
      id: '',
      projectName: projectName,
      description: description,
      projectIcon: '',
      userId: userData.uid,
      projectManager: userData.uid,
      updatedAt: time,
      createdAt: time,
      teamMembers: teamMembers,
      startDate: startDate,
      endDate: endDate,
    );

    final ref = Authentication.firestore.collection('projects').doc();
    await ref.set(projectData.toJson());

    if (ref.id.isNotEmpty) {
      final imageUrl = await uploadImage(projectIcon, 'project', ref.id);
      await ref.update({'id': ref.id, 'project_icon': imageUrl});
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> uploadImage(
      File file, String type, String docId) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final ext = file.path.split('.').last;
    final ref = Authentication.firebaseStorage
        .ref()
        .child('${type}s/${docId}_$time.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
    final imageUrl = await ref.getDownloadURL();
    return imageUrl;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMyprojects() {
    return Authentication.firestore
        .collection('projects/')
        .where(
          'user_id',
          isEqualTo: Authentication.user.uid,
        )
        .snapshots();
  }

  static Future<bool> createTask(
      String taskName,
      Project project,
      String description,
      String startDate,
      String endDate,
      String checkPoints) async {
    final userData = Authentication.user;

    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final ref = Authentication.firestore.collection('tasks').doc();
    final TaskModel taskData = TaskModel(
      id: ref.id,
      assignedBy: '',
      assignedTo: '',
      taskName: taskName,
      description: description,
      projectId: project.id,
      userId: userData.uid,
      updatedAt: time,
      createdAt: time,
      startDate: startDate,
      endDate: endDate,
      status: 'Pending',
    );
    await ref.set(taskData.toJson());
    await addCheckPoints(checkPoints, project.id, ref.id);

    if (ref.id.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> addCheckPoints(
      String checkPoints, String projectId, taskId) async {
    final userData = Authentication.user;

    final time = DateTime.now().millisecondsSinceEpoch.toString();

    List<String> checkponits = checkPoints.split(',');
    checkponits.forEach((element) async {
      final ref = Authentication.firestore.collection('checkpoints').doc();
      final CheckPoints checkPointData = CheckPoints(
        id: ref.id,
        taskId: taskId,
        projectId: projectId,
        userId: userData.uid,
        updatedAt: time,
        createdAt: time,
        status: 'Pending',
        checkpoint: element,
      );
      await ref.set(checkPointData.toJson());
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMyTasks() {
    return Authentication.firestore
        .collection('tasks/')
        .where(
          'user_id',
          isEqualTo: Authentication.user.uid,
        )
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMyTaskByProject(
      String projectId) {
    return Authentication.firestore
        .collection('tasks')
        .where(
          'project_id',
          isEqualTo: projectId,
        )
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      filterTaskByandProjectByStatus(String projectId, String status) {
    return Authentication.firestore
        .collection('tasks')
        .where('project_id', isEqualTo: projectId)
        .where('status', isEqualTo: status)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> filterTaskByDate() {
    final time = DateTime.now();
    final date = '${time.day}/${time.month}/${time.year}';
    return Authentication.firestore
        .collection('tasks')
        .where('start_date', isEqualTo: date)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllCheckPointsByTask(
      taskId) {
    return Authentication.firestore
        .collection('checkpoints')
        .where('task_id', isEqualTo: taskId)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getCheckPointsByStatus(
      taskId, status) {
    return Authentication.firestore
        .collection('checkpoints')
        .where('task_id', isEqualTo: taskId)
        .where('status', isEqualTo: status)
        .snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> filterTaskByDateAndStatus(
      String status) {
    final time = DateTime.now();
    final date = '${time.day}/${time.month}/${time.year}';
    // print(date);
    return Authentication.firestore
        .collection('tasks')
        .where('start_date', isEqualTo: date)
        .where('status', isEqualTo: status)
        .where('user_id', isEqualTo: Authentication.user.uid)
        .snapshots();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getprojectInfo(
      String id) {
    return Authentication.firestore.collection('projects').doc(id).snapshots();
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getTaskInfo(
      String taskId) {
    return Authentication.firestore.collection('tasks').doc(taskId).snapshots();
  }

  static Future<void> deleteTask(taskId) async {
    await Authentication.firestore.collection('tasks').doc(taskId).delete();
  }

  static countProjectProgress(double totaltask, double completedTask) {
    final double progress = (completedTask / totaltask) * 100;
    if (completedTask == 0) {
      return 0.0;
    } else {
      return progress;
    }
  }

  static Future<void> deleteproject(Project project) async {
    await Authentication.firestore
        .collection('projects')
        .doc(project.id)
        .delete();
    await Authentication.firebaseStorage
        .refFromURL(project.projectIcon)
        .delete();
    Authentication.firestore
        .collection('tasks')
        .where('project_id', isEqualTo: project.id)
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                element.reference.delete();
              })
            });
  }
}
