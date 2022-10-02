import 'dart:convert';


Attendance cargoPriceListModelFromJson(String str) =>
    Attendance.fromJson(json.decode(str));

String cargoPriceListModelToJson(Attendance data) => json.encode(data.toJson());

class Attendance {
    // String admin;
  List<Student> student;

  Attendance({
    // required this.admin,
    required this.student,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
    // admin: json["admin"],
    student: List<Student>.from(json["student"]
        .map((x) => Student.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    // "id": id,
    "student":  List<dynamic>.from(student.map((x) => x.toJson())),
  };
}

class Student {
  String username;
  String email;
  // int plastics;


  Student({
    required this.username,
    required this.email,
    // required this.plastics,

  });

  factory Student.fromJson(Map<String, dynamic> json) =>
      Student(
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() =>
      {
        "email": email,
        "username": username,
      };
}

