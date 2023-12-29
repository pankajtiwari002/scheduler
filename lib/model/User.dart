class User {
  String name;
  String email;
  String fcm;
  String uid;
  List<dynamic> taskSchedule;

  User(
      {required this.name,
      required this.email,
      required this.fcm,
      required this.uid,
      required this.taskSchedule});

  // Convert User model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'fcm': fcm,
      'uid': uid,
      'taskSchedule': taskSchedule
    };
  }

  // Create User model from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        fcm: json['fcm'] ?? '',
        uid: json['uid'] ?? '',
        taskSchedule: json['taskSchedule']);
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, fcm: $fcm}';
  }
}
