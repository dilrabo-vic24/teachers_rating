class NetworkConstants {
  static const String baseUrl = "http://152.42.148.49:4000/api";

  static const String studentLoginUrl = "$baseUrl/student/login";
  static const String studentRegisterUrl = "$baseUrl/student/create";

  static const String allTeachersUrl = "$baseUrl/teacher/all";
  static const String teacherById = "$baseUrl/teacher";
  static const String teacherByName = "$baseUrl/teacher/ByName";

  static const String teacherBySubject = "$baseUrl/teacher/BySubject";
  static const String getCommentsByTeachersId = "$baseUrl/comment/ByTeacherId";
  static const String addComment = "$baseUrl/comment/create";
  static const String getStudentById = "$baseUrl/student";
}
