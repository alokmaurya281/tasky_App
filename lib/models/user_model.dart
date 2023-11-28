class UserModel {
  late String id;
  late String name;
  late String about;
  late String image;
  late String lastActive;
  late String email;
  late String pushToken;
  late String createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.about,
    required this.image,
    required this.lastActive,
    required this.email,
    required this.pushToken,
    required this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    about = json['about'] ?? '';
    image = json['image'] ?? '';
    lastActive = json['last_active'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    createdAt = json['created_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['email'] = email;
    data['push_token'] = pushToken;
    return data;
  }
}
