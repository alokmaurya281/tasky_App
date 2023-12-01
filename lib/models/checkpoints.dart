class CheckPoints {
  late String id;
  late String checkpoint;
  late String projectId;
  late String taskId;
  late String userId;
  late String createdAt;
  late String updatedAt;
  late String status;

  CheckPoints({
    required this.id,
    required this.projectId,
    required this.userId,
    required this.taskId,
    required this.updatedAt,
    required this.createdAt,
    required this.status,
    required this.checkpoint,
  });

  CheckPoints.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';

    userId = json['user_id'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    createdAt = json['created_at'] ?? '';
    projectId = json['project_id'] ?? '';
    taskId = json['task_id'] ?? '';

    status = json['status'] ?? '';
    checkpoint = json['checkpoint'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data['created_at'] = createdAt;
    data['id'] = id;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['project_id'] = projectId;
    data['task_id'] = taskId;

    data['status'] = status;
    data['checkpoint'] = checkpoint;

    return data;
  }
}
