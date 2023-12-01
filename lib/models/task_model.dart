class TaskModel {
  late String id;
  late String taskName;
  late String projectId;
  late String description;
  late String startDate;
  late String endDate;
  late String userId;
  late String assignedTo;
  late String assignedBy;
  late String createdAt;
  late String updatedAt;
  late String status;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.description,
    required this.projectId,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.assignedBy,
    required this.assignedTo,
    required this.status,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    description = json['description'] ?? '';
    taskName = json['task_name'] ?? '';
    userId = json['user_id'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    createdAt = json['created_at'] ?? '';
    projectId = json['project_id'] ?? '';
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    assignedBy = json['assigned_by'] ?? '';
    assignedTo = json['assigned_to'] ?? '';
    status = json['status'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['description'] = description;
    data['task_name'] = taskName;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['project_id'] = projectId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['assigned_by'] = assignedBy;
    data['assigned_to'] = assignedTo;
    data['status'] = status;

    return data;
  }
}
