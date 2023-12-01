class Project {
  late String id;
  late String projectName;
  late String description;
  late String projectIcon;
  late String userId;
  late String createdAt;
  late String updatedAt;
  late String teamMembers;
  late String startDate;
  late String endDate;
  late String projectManager;

  Project({
    required this.id,
    required this.projectName,
    required this.description,
    required this.projectIcon,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.teamMembers,
    required this.startDate,
    required this.endDate,
    required this.projectManager,
  });

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    projectIcon = json['project_icon'] ?? '';
    description = json['description'] ?? '';
    projectName = json['project_name'] ?? '';
    userId = json['user_id'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    createdAt = json['created_at'] ?? '';
    startDate = json['start_date'] ?? '';
    endDate = json['end_date'] ?? '';
    teamMembers = json['team_members'] ?? '';
    projectManager = json['project_manager'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['project_icon'] = projectIcon;
    data['description'] = description;
    data['project_name'] = projectName;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['start_date'] = startDate;
    data['team_members'] = teamMembers;
    data['end_date'] = endDate;
    data['project_manager'] = projectManager;
    return data;
  }
}
