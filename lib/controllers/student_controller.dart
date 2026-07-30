import 'package:get/get.dart';

class Student {
  int id;
  String name;
  int age;
  Student({required this.id, required this.name, required this.age});
}

class StudentController extends GetxController {
  var students = <Student>[].obs;

  void addStudent(String name, int age) {
    int id = students.isEmpty ? 1 : students.last.id + 1;
    students.add(Student(id: id, name: name, age: age));
  }

  void updateStudent(int id, String name, int age) {
    int index = students.indexWhere((s) => s.id == id);
    if (index != -1) {
      students[index] = Student(id: id, name: name, age: age);
    }
  }

  void deleteStudent(int id) {
    students.removeWhere((s) => s.id == id);
  }
}