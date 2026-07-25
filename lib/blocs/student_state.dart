import 'package:bloc_task/models/student_model.dart' show Student;

abstract class StudentState {}

class StudentInitial extends StudentState {}

class StudentLoadingState extends StudentState {}

class StudentLoadedState extends StudentState {
  final List<Student> students;

  StudentLoadedState({required this.students});
}

class StudentErrorState extends StudentState {
  final String message;

  StudentErrorState({required this.message});
}