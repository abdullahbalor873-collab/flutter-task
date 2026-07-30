abstract class StudentEvent {}

class LoadStudentsEvent extends StudentEvent {}

class AddStudentEvent extends StudentEvent {
  final String name;
  final int age;

  AddStudentEvent({required this.name, required this.age});
}

class UpdateStudentEvent extends StudentEvent {
  final String id;
  final String name;
  final int age;

  UpdateStudentEvent({required this.id, required this.name, required this.age});
}

class DeleteStudentEvent extends StudentEvent {
  final String id;

  DeleteStudentEvent({required this.id});
}